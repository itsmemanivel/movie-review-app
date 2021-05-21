import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/utils/commons.dart';

import '../utils/bottomNavigationBarCard.dart';
import 'home/movies.dart';

class DashBoard extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DashBoard> {
  int _currentIndex = 0;
  PageController _pageController;

  List<Widget> pages = [
    MoviesPage(),
    MoviesPage(),
    MoviesPage(),
    MoviesPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: pages),
      ),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 5,
        backgroundColor: Commons.bgColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: Text('Movies'),
            textAlign: TextAlign.center,
            icon: Icon(
              CupertinoIcons.film,
              color: Colors.white,
            ),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text('TV Shows'),
            textAlign: TextAlign.center,
            icon: Icon(
              CupertinoIcons.tv,
              color: Colors.white,
            ),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text('Explore'),
            textAlign: TextAlign.center,
            icon: Icon(
              CupertinoIcons.search,
              color: Colors.white,
            ),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            title: Text('Favorites'),
            textAlign: TextAlign.center,
            icon: Icon(
              CupertinoIcons.heart_fill,
              color: Colors.white,
            ),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
