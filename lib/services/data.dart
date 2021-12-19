import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/view_models/errors.dart';

class DataService {
  String url = "https://gist.githubusercontent.com/saniyusuf/406b843afdfb9c6a86e25753fe2761f4/raw/523c324c7fcc36efab8224f9ebb7556c09b69a14/Film.JSON";

  Future<List<Movie>> getMovies() async {
    var response = await Dio().get(url);
    if (response.statusCode != 200) {
      throw UserFriendlyException(message: "Error Fetching data");
    } else {
      List<dynamic> data = jsonDecode(response.data);
      List<Movie> movies =  data.map((e) {
        return Movie.fromJson(e);
      }).toList();
      movies.removeWhere((element) => element.title.toLowerCase().contains("I Am Legend".toLowerCase()));
      return movies;
    }
  }
}
