import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/tvshow-list.dart';
import 'package:movie_app/utils/commons.dart';
import 'package:movie_app/views/tvshows/tv-show-provider.dart';
import 'package:provider/provider.dart';

import 'tv-show-card.dart';

class TvShowsPage extends StatefulWidget {
  @override
  _TvShowsPageState createState() => _TvShowsPageState();
}

class _TvShowsPageState extends State<TvShowsPage> {
  TvShowsPageProvider _tvShowPageProvider;

  @override
  void initState() {
    super.initState();
    _tvShowPageProvider = Provider.of<TvShowsPageProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => _tvShowPageProvider.initiateTvShowsPage());
  }

  @override
  Widget build(BuildContext context) {
    _tvShowPageProvider = Provider.of<TvShowsPageProvider>(context);
    return Scaffold(
      backgroundColor: Commons.bgColor,
      body: SafeArea(
        child: _tvShowPageProvider.isLoading
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
                        width: 226,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.film,
                              color: Commons.blueColor,
                            ),
                            Text(
                              ' RMDB TV SHOWS',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                            ),
                          ],
                        ),
                      ),
                      centerTitle: true,
                    ),
                    titleCard(title: 'TopRated'),
                    if (_tvShowPageProvider.topRatedShows.tvShows.length >= 5)
                      tvShowList(tvShowList: _tvShowPageProvider.topRatedShows),
                    titleCard(title: 'On the Air'),
                    if (_tvShowPageProvider.onTheAirShows.tvShows.length >= 5)
                      tvShowList(tvShowList: _tvShowPageProvider.onTheAirShows),
                    titleCard(title: 'Airing Today'),
                    if (_tvShowPageProvider.airingTodayShows.tvShows.length >= 6)
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 7.0 / 10,
                        crossAxisCount: 2,
                        children: List.generate(6, (index) {
                          return TvShowCard(
                            tvShow: _tvShowPageProvider.airingTodayShows.tvShows[index],
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
                    titleCard(title: 'Popular among people'),
                    if (_tvShowPageProvider.popularShows.tvShows.length >= 5)
                      tvShowList(tvShowList: _tvShowPageProvider.popularShows),
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

  Widget tvShowList({@required TvShowsList tvShowList}) {
    return Container(
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tvShowList.tvShows.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == tvShowList.tvShows.length)
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
          return TvShowCard(tvShow: tvShowList.tvShows[index]);
        },
      ),
    );
  }
}
