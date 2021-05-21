import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie-list.dart';
import 'package:movie_app/utils/commons.dart';

class TopRatedWidget extends StatefulWidget {
  final MovieList movielist;

  const TopRatedWidget({Key key, @required this.movielist}) : super(key: key);

  @override
  _TopRatedWidgetState createState() => _TopRatedWidgetState();
}

class _TopRatedWidgetState extends State<TopRatedWidget> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            viewportFraction: 1,
            // enableInfiniteScroll: false,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: [1, 2, 3, 4, 5].map((index) {
            return Builder(
              builder: (BuildContext context) {
                String imgUrl = widget.movielist.movies[index].backdropPath;
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                        image:
                            DecorationImage(image: NetworkImage('${Commons.imageBaseUrl}$imgUrl'), fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 20,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          widget.movielist.movies[index].title,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Text(
                        'Top rated movies',
                        style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w800, fontSize: 12),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
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
                              size: 12,
                            ),
                            Text(
                              ' ' + widget.movielist.movies[index].voteAverage.toString() + ' ',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4, 5].map((url) {
            int index = [1, 2, 3, 4, 5].indexOf(url);
            return Container(
              width: 5.0,
              height: 5.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.white : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
