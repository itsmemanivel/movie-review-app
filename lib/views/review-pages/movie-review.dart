import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/movie-review-model.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/utils/dio-request.dart';

class MovieReviewPage extends StatefulWidget {
  final num id;
  final String imgUrl;
  final String title;

  const MovieReviewPage({Key key, @required this.id, this.imgUrl, this.title}) : super(key: key);
  @override
  _MovieReviewPageState createState() => _MovieReviewPageState();
}

class _MovieReviewPageState extends State<MovieReviewPage> {
  Review review;
  Casting casting;
  bool loading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getMovieReview());
  }

  getMovieReview() async {
    setState(() {
      loading = true;
    });
    try {
      final responce = await movieDio.get(Commons.movieReviewLink(id: widget.id));
      final castingResponce = await movieDio.get(Commons.castLink(id: widget.id));
      setState(() {
        review = Review.fromJson(responce.data);
      });
      setState(() {
        casting = Casting.fromJson(castingResponce.data);
      });
      print(castingResponce.data);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print('>>>>>>>>>> error: $e <<<<<<<<<<<');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Commons.bgColor,
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CustomPaint(
                          foregroundPainter: FadingEffect(),
                          child: Image.network(widget.imgUrl),
                        ),
                        Positioned(
                            top: 20,
                            left: 20,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black54,
                                            blurRadius: 1.0, // soften the shadow
                                            spreadRadius: 1.5, //extend the shadow
                                            offset: Offset(
                                              1.0, // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ))
                                      ]),
                                  child: Icon(Icons.navigate_before_outlined)),
                            )),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Text(
                            widget.title,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    if (casting.cast.isNotEmpty) castingWidget(),
                    if (review.results.isNotEmpty) contentWidget(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget titleCard({String title}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      child: Text(
        title ?? '',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
      ),
    );
  }

  Widget castingWidget() {
    return Column(
      children: [
        titleCard(title: 'Casting'),
        Container(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: casting.cast.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (casting.cast[index].profilePath != null)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            image: NetworkImage('${Commons.imageBaseUrl}${casting.cast[index].profilePath}'),
                            fit: BoxFit.contain),
                      ),
                    )
                  else
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        casting.cast[index].originalName.substring(0, 1).toUpperCase(),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 35),
                      ),
                    ),
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    child: Text(
                      casting.cast[index].originalName ?? '',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 10),
                    ),
                  ),
                  Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    alignment: Alignment.center,
                    child: Text(
                      casting.cast[index].knownForDepartment ?? '',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 10),
                    ),
                  ),
                  Container(
                    width: 120,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Character:' + casting.cast[index].character ?? '',
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget contentWidget() {
    return Column(
      children: [
        titleCard(title: 'Story'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            review.results[0]?.content ?? '',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class FadingEffect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    LinearGradient lg = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
      //create 2 white colors, one transparent
      Colors.transparent,
      Commons.bgColor,
    ]);
    Paint paint = Paint()..shader = lg.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(FadingEffect linePainter) => false;
}
