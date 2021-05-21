import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie-list.dart';
import 'package:movie_app/models/tvshow-list.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/utils/dio-request.dart';
import 'package:movie_app/views/movies/movie-card.dart';
import 'package:movie_app/views/tvshows/tv-show-card.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  TextEditingController _controller = TextEditingController();
  MovieList _movieList;
  TvShowsList _tvShowsList;
  bool loading = false;

  setLoading() {
    setState(() {
      loading = true;
    });
  }

  removeLoading() {
    setState(() {
      loading = false;
    });
  }

  void onSearch(String value) async {
    print('searching...');
    if (value.isNotEmpty) {
      try {
        setLoading();
        final responce = await dio.get(Commons.searchMovieLink(value: value));
        final tvShowResponce = await dio.get(Commons.searchTvShowsLink(value: value));
        setState(() {
          _movieList = MovieList.fromJson(responce.data);
          _tvShowsList = TvShowsList.fromJson(tvShowResponce.data);
        });
        print(tvShowResponce.data);
        removeLoading();
      } catch (e) {
        removeLoading();
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Commons.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            cursorColor: Colors.white,
            controller: _controller,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Movies, Tv Shows',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            onChanged: (value) async {
              await onSearch(value);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_movieList != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                width: MediaQuery.of(context).size.width,
                color: Colors.white12,
                child: Text(
                  'Movies',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                ),
              ),
            if (_movieList != null)
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 3 / 5,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                children: List.generate(
                    _movieList.movies.length > 4 ? 4 : _movieList.movies.length,
                    (index) => MovieCard(
                          movie: _movieList.movies[index],
                          width: MediaQuery.of(context).size.width,
                        )),
              ),
            if (_tvShowsList != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                width: MediaQuery.of(context).size.width,
                color: Colors.white12,
                child: Text(
                  'TvShows',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                ),
              ),
            if (_tvShowsList != null)
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 3 / 5,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                crossAxisCount: 2,
                children: List.generate(
                    _tvShowsList.tvShows.length > 4 ? 4 : _tvShowsList.tvShows.length,
                    (index) => TvShowCard(
                          tvShow: _tvShowsList.tvShows[index],
                          width: MediaQuery.of(context).size.width,
                        )),
              ),
          ],
        ),
      ),
    );
  }
}
