import 'dart:convert';

import 'package:escribo_teste_03/models/people.dart';
import 'package:http/http.dart';

class PeopleController {
  PeopleController();

  String baseUrl = 'https://swapi.dev/api/';

  Future<int> getPagesNumber() async {
    Uri url = Uri.parse(baseUrl + 'people');

    Response response = await get(url);

    Map<String, dynamic> res = jsonDecode(response.body);

    double pages = res['count'] / 10;

    return pages.ceil();
  }

  Future<List<People>> listMovies({int page = 1}) async {
    Uri url = Uri.parse(baseUrl + 'people/?page=$page');
    List<People> people = [];

    Response response = await get(url);

    Map<String, dynamic> res = jsonDecode(response.body);

    for (Map<String, dynamic> movie in res['results']) {
      people.add(People.fromJson(movie));
    }

    return people;
  }
}
