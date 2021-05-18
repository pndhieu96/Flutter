// @dart=2.9
import 'package:flutter_fetch_data/models/MovieResponse.dart';
import 'package:flutter_fetch_data/networking/ApiBaseHelper.dart';

import 'apiKey.dart';

class MovieDetailRepository {
  final String _apiKey = apiKey;
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(int selectedMovie) async {
    final response = await _helper.get("movie/$selectedMovie?api_key=$_apiKey");
    print('fetchMovieDetail: $response');
    return Movie.fromJson(response);
  }
}