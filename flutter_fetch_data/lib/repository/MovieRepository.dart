// @dart=2.9
import 'package:flutter_fetch_data/models/MovieResponse.dart';
import 'package:flutter_fetch_data/networking/ApiBaseHelper.dart';

import 'apiKey.dart';

class MovieRepository {
  final String _apiKey = apiKey;
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    print('fetchMovieList: $response');
    return MovieResponse.fromJson(response).results;
  }
}