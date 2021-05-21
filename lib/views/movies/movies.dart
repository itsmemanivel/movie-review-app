import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie-list.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/views/movies/movie-card.dart';
import 'package:movie_app/views/movies/movies-provider.dart';
import 'package:movie_app/views/movies/movies-toprated-widget.dart';
import 'package:provider/provider.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MoviesPageProvider _homePageProvider;

  @override
  void initState() {
    super.initState();
    _homePageProvider = Provider.of<MoviesPageProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => _homePageProvider.initiateHomePage());
  }

  @override
  Widget build(BuildContext context) {
    _homePageProvider = Provider.of<MoviesPageProvider>(context);
    return Scaffold(
      backgroundColor: Commons.bgColor,
      body: SafeArea(
        child: _homePageProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Commons.bgColor,
                      title: Container(
                        width: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.film,
                              color: Commons.blueColor,
                            ),
                            Text(
                              ' RMDB MOVIES',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    ),
                    titleCard(title: 'Top Rated'),
                    if (_homePageProvider.topRatedMovies.movies.length >= 5)
                      TopRatedWidget(
                        movielist: _homePageProvider.topRatedMovies,
                      ),
                    titleCard(title: 'Today\'s Trending'),
                    if (_homePageProvider.trendingMovies.movies.length >= 5)
                      movieList(movieList: _homePageProvider.trendingMovies),
                    titleCard(title: 'Popular Movies'),
                    if (_homePageProvider.popularMovies.movies.length >= 5)
                      movieList(movieList: _homePageProvider.popularMovies),
                    titleCard(title: 'Now Streaming'),
                    if (_homePageProvider.nowPlayingMovies.movies.length >= 4)
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 7.0 / 10,
                        crossAxisCount: 2,
                        children: List.generate(4, (index) {
                          return MovieCard(
                            movie: _homePageProvider.nowPlayingMovies.movies[index],
                            width: MediaQuery.of(context).size.width / 2,
                            textSize: 14,
                          );
                        }),
                      ),
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'More',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            Icon(
                              Icons.navigate_next_rounded,
                              size: 25,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    titleCard(title: 'UpComing'),
                    if (!_homePageProvider.isLoading && _homePageProvider.upcomingMovies.movies.length >= 4)
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 7.0 / 10,
                        crossAxisCount: 2,
                        children: List.generate(4, (index) {
                          return MovieCard(
                            movie: _homePageProvider.upcomingMovies.movies[index],
                            width: MediaQuery.of(context).size.width / 2,
                            textSize: 14,
                          );
                        }),
                      ),
                    ListTile(
                      title: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'More',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                            ),
                            Icon(
                              Icons.navigate_next_rounded,
                              size: 25,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
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
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
      ),
    );
  }

  Widget movieList({@required MovieList movieList}) {
    return Container(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: movieList.movies.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == movieList.movies.length)
            return Container(
              height: 200,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white10,
              ),
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Icon(
                Icons.navigate_next_rounded,
                size: 75,
                color: Colors.white54,
              ),
            );
          return MovieCard(movie: movieList.movies[index]);
        },
      ),
    );
  }
}
