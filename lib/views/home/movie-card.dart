import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/views/review-pages/movie-review.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final double width;
  final double textSize;

  const MovieCard({Key key, @required this.movie, this.width, this.textSize}) : super(key: key);
  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MovieReviewPage(
                    id: widget.movie.id,
                    imgUrl: '${Commons.imageBaseUrl}${widget.movie.posterPath}',
                    title: widget.movie.title)));
      },
      child: Stack(
        children: [
          Container(
            width: widget.width ?? 140,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage('${Commons.imageBaseUrl}${widget.movie.posterPath}'), fit: BoxFit.fill),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          ),
          Container(
            width: widget.width ?? 140,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          ),
          Positioned(
            top: 15,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white.withOpacity(.4),
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
                    ' ' + widget.movie.voteAverage.toString() + ' ',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: Text(
              widget.movie.title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: widget.textSize ?? 10),
            ),
          ),
        ],
      ),
    );
  }
}
