import 'package:flutter/material.dart';
import 'package:movie_app/views/dashboard.dart';
import 'package:movie_app/views/movies/movies-provider.dart';
import 'package:movie_app/views/tvshows/tv-show-provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MoviesPageProvider()),
        ChangeNotifierProvider(create: (context) => TvShowsPageProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: DashBoard(),
          routes: <String, WidgetBuilder>{
            '/spalsh': (BuildContext context) => DashBoard(),
          }),
    );
  }
}
