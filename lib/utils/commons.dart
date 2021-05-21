import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Commons {
  //movie/578701/credits?api_key=ee2c4d00a712b8be561329d22c99a4c5&language=en-US
  //movie/{movie_id}/reviews?api_key=<<api_key>>&language=en-US&page=1
  static const movieAPIKey = 'ee2c4d00a712b8be561329d22c99a4c5';
  static const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const baseUrl = 'https://api.themoviedb.org/3/';

  static String nowPlayingMoviesLink({int pageNumber}) {
    return 'movie/now_playing?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String popularMoviesLink({int pageNumber}) {
    return 'movie/popular?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String topRatedMoviesLink({int pageNumber}) {
    return 'movie/top_rated?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String upcomingMoviesLink({int pageNumber}) {
    return 'movie/upcoming?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String trendingMoviesLink({int pageNumber}) {
    return 'trending/movie/day?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String movieReviewLink({num id}) {
    return 'movie/$id/reviews?api_key=$movieAPIKey&language=en-US&page=1';
  }

  static String searchMovieLink({String value}) {
    return 'search/movie?api_key=$movieAPIKey&query=$value';
  }

  static String searchTvShowsLink({String value}) {
    return 'search/tv?api_key=$movieAPIKey&query=$value';
  }

  static String movieCastLink({num id}) {
    return 'movie/$id/credits?api_key=$movieAPIKey&language=en-US&page=1';
  }

  static String showCastLinkLink({num id}) {
    return 'tv/$id/credits?api_key=$movieAPIKey&language=en-US&page=1';
  }

  static String showDetailsLink({num id}) {
    return 'tv/$id?api_key=$movieAPIKey&language=en-US&page=1';
  }

  static String movieDetailsLink({num id}) {
    return 'movie/$id?api_key=$movieAPIKey&language=en-US&page=1';
  }

  static String topRatedShowsLink({int pageNumber}) {
    return 'tv/top_rated?api_key=$movieAPIKey&language=ta&page=${pageNumber ?? 1}';
  }

  static String airingTodayShowsLink({int pageNumber}) {
    return 'tv/airing_today?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String onTheAirShowsLink({int pageNumber}) {
    return 'tv/on_the_air?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String popularShowsLink({int pageNumber}) {
    return 'tv/popular?api_key=$movieAPIKey&language=en-US&page=${pageNumber ?? 1}';
  }

  static String showEpisodesLink({num id}) {
    return 'tv/$id?api_key=$movieAPIKey&language=en-US&page=1';
  }

  static const hintColor = Color(0xFF4D0F29);
  static Color blueColor = Colors.blue;
  static Color bgLightColor = Commons.colorFromHex('#e6f7ff');
  static Color bgColor = Commons.colorFromHex('#00011a');

  static Color greyAccent1 = Commons.colorFromHex('#f7f7f7');
  static Color greyAccent2 = Commons.colorFromHex('#cccccc');
  static Color greyAccent3 = Commons.colorFromHex('#999999');
  static Color greyAccent4 = Commons.colorFromHex('#8e8e93');
  static Color greyAccent5 = Commons.colorFromHex('#333333');

  static Color colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static AppBar appBar = AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'SPORT',
          style: TextStyle(fontFamily: 'Nunito', color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25),
        ),
        Text(
          'O',
          style: TextStyle(fontFamily: 'Nunito', color: Colors.blue, fontWeight: FontWeight.w800, fontSize: 25),
        ),
      ],
    ),
  );
}
