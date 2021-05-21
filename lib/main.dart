import 'package:flutter/material.dart';
import 'package:movie_app/views/dashboard.dart';
import 'package:movie_app/views/home/movies-provider.dart';
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
