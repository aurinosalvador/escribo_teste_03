import 'dart:convert';

import 'package:escribo_teste_03/models/movie.dart';
import 'package:http/http.dart';

class MovieController {
  MovieController();

  String baseUrl = 'https://swapi.dev/api/';

  Future<List<Movie>> listMovies() async {
    Uri url = Uri.parse(baseUrl + 'films');
    List<Movie> movies = [];

    Response response = await get(url);

    Map<String, dynamic> res = jsonDecode(response.body);

    for (Map<String, dynamic> movie in res['results']) {
      movies.add(Movie.fromJson(movie));
    }

    return movies;
  }
}
