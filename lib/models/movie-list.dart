import 'movie.dart';

class MovieList {
  num page;
  List<Movie> movies = [];
  num totalPages;
  num totalResults;

  MovieList({this.page, this.movies, this.totalPages, this.totalResults});

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movies = new List<Movie>();
      json['results'].forEach((value) {
        movies.add(new Movie.fromJson(value));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.movies != null) {
      data['results'] = this.movies.map((value) => value.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }
}
