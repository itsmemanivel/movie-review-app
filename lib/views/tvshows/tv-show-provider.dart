import 'package:flutter/material.dart';
import 'package:movie_app/models/tvshow-list.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/utils/dio-request.dart';

class TvShowsPageProvider extends ChangeNotifier {
  TvShowsList _airingTodayShows;
  TvShowsList _onTheAirShows;
  TvShowsList _topRatedShows;
  TvShowsList _popularShows;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  TvShowsList get airingTodayShows => _airingTodayShows;
  TvShowsList get onTheAirShows => _onTheAirShows;
  TvShowsList get topRatedShows => _topRatedShows;
  TvShowsList get popularShows => _popularShows;

  initiateTvShowsPage() async {
    _isLoading = true;
    await getAiringToday();
    await getOnTheAir();
    await getTopRatedShows();
    await getPopularShows();
    _isLoading = false;
    notifyListeners();
  }

  getAiringToday() async {
    try {
      final responce = await dio.get(Commons.airingTodayShowsLink());
      _airingTodayShows = TvShowsList.fromJson(responce.data);
    } catch (e) {
      print(e);
    }
  }

  getOnTheAir() async {
    try {
      final responce = await dio.get(Commons.onTheAirShowsLink());
      _onTheAirShows = TvShowsList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getTopRatedShows() async {
    try {
      final responce = await dio.get(Commons.topRatedShowsLink());
      _topRatedShows = TvShowsList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getPopularShows() async {
    try {
      final responce = await dio.get(Commons.popularShowsLink());
      _popularShows = TvShowsList.fromJson(responce.data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
