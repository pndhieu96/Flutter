// @dart=2.9
import 'dart:async';

import 'package:flutter_fetch_data/models/MovieResponse.dart';
import 'package:flutter_fetch_data/networking/ApiResponse.dart';
import 'package:flutter_fetch_data/repository/MovieRepository.dart';

class MovieBloc {
  MovieRepository _movieRepository;
  StreamController _movieListController;

  StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
      _movieListController?.sink as StreamSink<ApiResponse<List<Movie>>>;

  Stream<ApiResponse<List<Movie>>> get movieListStream =>
      _movieListController?.stream as Stream<ApiResponse<List<Movie>>>;

  MovieBloc() {
    _movieListController = StreamController<ApiResponse<List<Movie>>>();
    _movieRepository = MovieRepository();
    fetchMovieList();
  }

  fetchMovieList() async {
    movieListSink.add(ApiResponse.loading('Fetching Movies'));
    try {
      List<Movie> movies = await _movieRepository.fetchMovieList();
      movieListSink.add(ApiResponse.completed(movies));
    } catch (e) {
      movieListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  dispose() {
    _movieListController.close();
  }
}