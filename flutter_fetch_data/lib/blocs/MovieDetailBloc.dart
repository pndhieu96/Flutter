// @dart=2.9
import 'dart:async';

import 'package:flutter_fetch_data/models/MovieResponse.dart';
import 'package:flutter_fetch_data/networking/ApiResponse.dart';
import 'package:flutter_fetch_data/repository/MovieDetailRepository.dart';

class MovieDetailBloc {
  MovieDetailRepository _movieDetailRepository;
  StreamController _movieDetailController;

  StreamSink<ApiResponse<Movie>> get movieDetailSink =>
      _movieDetailController.sink as StreamSink<ApiResponse<Movie>>;
  Stream<ApiResponse<Movie>> get movieDetailStream =>
      _movieDetailController.stream as Stream<ApiResponse<Movie>>;

  MovieDetailBloc(selectedMovie) {
    _movieDetailController = StreamController<ApiResponse<Movie>>();
    _movieDetailRepository = MovieDetailRepository();
    fetchMovieDetail(selectedMovie);
  }

  fetchMovieDetail(int selectedMovie) async {
    movieDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      Movie details =
      await _movieDetailRepository.fetchMovieDetail(selectedMovie);
      movieDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      movieDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _movieDetailController.close();
  }
}
