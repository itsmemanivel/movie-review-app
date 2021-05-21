import 'package:movie_app/models/tvshows.dart';

class TvShowsList {
  num page;
  List<TvShow> tvShows;
  num totalPages;
  num totalResults;

  TvShowsList({this.page, this.tvShows, this.totalPages, this.totalResults});

  TvShowsList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      tvShows = new List<TvShow>();
      json['results'].forEach((v) {
        tvShows.add(new TvShow.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.tvShows != null) {
      data['results'] = this.tvShows.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
