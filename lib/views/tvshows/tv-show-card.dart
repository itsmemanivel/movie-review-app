import 'package:flutter/material.dart';
import 'package:movie_app/models/tvshows.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/views/review-pages/show-review-page.dart';

class TvShowCard extends StatefulWidget {
  final TvShow tvShow;
  final double width;
  final double textSize;

  const TvShowCard({Key key, @required this.tvShow, this.width, this.textSize}) : super(key: key);
  @override
  _TvShowCardState createState() => _TvShowCardState();
}

class _TvShowCardState extends State<TvShowCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ShowReviewPage(
                      tvShow: widget.tvShow,
                    )));
      },
      child: Stack(
        children: [
          Container(
            width: widget.width ?? 140,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage('${Commons.imageBaseUrl}${widget.tvShow.posterPath}'), fit: BoxFit.fill),
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
                    ' ' + widget.tvShow.voteAverage.toString() + ' ',
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
              widget.tvShow.name,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: widget.textSize ?? 10),
            ),
          ),
        ],
      ),
    );
  }
}
