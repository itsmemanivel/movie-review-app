import 'package:flutter/material.dart';
import 'package:movie_app/models/movie-list.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/utils/dio-request.dart';

class MoviesPageProvider extends ChangeNotifier {
  MovieList _topRatedMovies;
  MovieList _popularMovies;
  MovieList _nowPlayingMovies;
  MovieList _upcomingMovies;
  MovieList _trendingMovies;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  MovieList get topRatedMovies => _topRatedMovies;
  MovieList get popularMovies => _popularMovies;
  MovieList get nowPlayingMovies => _nowPlayingMovies;
  MovieList get trendingMovies => _trendingMovies;
  MovieList get upcomingMovies => _upcomingMovies;

  initiateHomePage() async {
    _isLoading = true;
    await getTopRatedMovies();
    await getPopularMovies();
    await getNowPlayingMovies();
    await getUpComingMovies();
    await getTrendingMovies();
    _isLoading = false;
    notifyListeners();
  }

  getTopRatedMovies() async {
    try {
      final responce = await movieDio.get(Commons.topRatedMoviesLink());
      _topRatedMovies = MovieList.fromJson(responce.data);
    } catch (e) {
      print(e);
    }
  }

  getPopularMovies() async {
    try {
      final responce = await movieDio.get(Commons.popularMoviesLink());
      _popularMovies = MovieList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getNowPlayingMovies() async {
    try {
      final responce = await movieDio.get(Commons.nowPlayingMoviesLink(pageNumber: 2));
      _nowPlayingMovies = MovieList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getUpComingMovies() async {
    try {
      final responce = await movieDio.get(Commons.upcomingMoviesLink());
      _upcomingMovies = MovieList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getTrendingMovies() async {
    try {
      final responce = await movieDio.get(Commons.trendingMoviesLink());
      _trendingMovies = MovieList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
