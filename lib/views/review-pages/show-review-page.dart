import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/models/tvshow-details.dart';
import 'package:movie_app/models/tvshows.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/utils/dio-request.dart';

class ShowReviewPage extends StatefulWidget {
  final TvShow tvShow;

  const ShowReviewPage({Key key, @required this.tvShow}) : super(key: key);
  @override
  _ShowReviewPageState createState() => _ShowReviewPageState();
}

class _ShowReviewPageState extends State<ShowReviewPage> {
  Casting casting;
  TvShowsDetails tvShowsDetails;
  bool loading = true;
  bool episodeLoading = true;
  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
      print(widget.tvShow.id);
      final castingResponce = await dio.get(Commons.showCastLinkLink(id: widget.tvShow.id));
      final detailsResponce = await dio.get(Commons.showDetailsLink(id: widget.tvShow.id));
      setState(() {
        casting = Casting.fromJson(castingResponce.data);
        tvShowsDetails = TvShowsDetails.fromJson(detailsResponce.data);
      });
      print(detailsResponce.data);
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

  getEpisodes() async {}

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
                          child: Image.network('${Commons.imageBaseUrl}${widget.tvShow.posterPath}'),
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
                                                1.0 // Move to bottom 10 Vertically
                                                ))
                                      ]),
                                  child: Icon(Icons.navigate_before_outlined)),
                            )),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Text(
                            widget.tvShow.name,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                    titleCard(title: 'OverView'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        widget.tvShow.overview ?? '',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                    if (tvShowsDetails != null) popularityCard(),
                    if (tvShowsDetails != null) languageCard(),
                    if (tvShowsDetails != null) genresCard(),
                    if (casting.cast.isNotEmpty) castingWidget(),
                    if (tvShowsDetails != null)
                      if (tvShowsDetails.seasons?.isNotEmpty) seasonsCard(),
                    if (tvShowsDetails == null) titleCard(title: 'No Seasons Available'),
                  ],
                ),
              ),
      ),
    );
  }

  Widget languageCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Origin Language: ${tvShowsDetails.originalLanguage.toUpperCase()}',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          Text(
            'Available Languages: ${tvShowsDetails.languages.toString().toUpperCase()}',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget popularityCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popularity, Total votes: ${(tvShowsDetails.popularity * 1000).round()}',
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white.withOpacity(.3),
            ),
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 14,
                ),
                Text(
                  ' ' + tvShowsDetails.voteAverage.toString() + ' ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget genresCard() {
    String genres = ' ';
    for (int i = 0; i < tvShowsDetails.genres.length; i++) {
      setState(() {
        genres += tvShowsDetails.genres[i].name + ', ';
      });
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Genres: ${genres.toUpperCase()}',
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }

  Widget seasonsCard() {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 7.0 / 15,
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 2,
      children: List.generate(
          tvShowsDetails.seasons.length,
          (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 1.5,
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage('${Commons.imageBaseUrl}${tvShowsDetails.seasons[index].posterPath}'),
                            fit: BoxFit.cover)),
                  ),
                  Text(
                    tvShowsDetails.seasons[index].name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                  Text(
                    'Total Episodes: ' + tvShowsDetails.seasons[index].episodeCount.toString(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 10),
                  ),
                  Text(
                    'Published on: ' + '${tvShowsDetails.seasons[index].airDate ?? 'not published'}',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 10),
                  ),
                ],
              )),
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
}

class FadingEffect extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    LinearGradient lg = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
      Colors.transparent,
      Commons.bgColor,
    ]);
    Paint paint = Paint()..shader = lg.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(FadingEffect linePainter) => false;
}
