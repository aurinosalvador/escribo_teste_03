import 'dart:convert';

import 'package:escribo_teste_03/models/api_model.dart';
import 'package:http/http.dart';

abstract class ApiController<T extends ApiModel> {
  final String _baseUrl = 'https://swapi.dev/api/';
  final String endpoint;

  ApiController(this.endpoint);

  T fromMap(Map<String, dynamic> map);

  Future<int> getPagesNumber() async {
    Uri url = Uri.parse(_baseUrl + endpoint);

    Response response = await get(url);

    Map<String, dynamic> res = jsonDecode(response.body);

    double pages = res['count'] / 10;

    return pages.ceil();
  }

  Future<List<T>> list({int page = 1}) async {
    Uri url = Uri.parse('$_baseUrl$endpoint/?page=$page');
    List<T> list = <T>[];

    Response response = await get(url);

    Map<String, dynamic> res = jsonDecode(response.body);

    for (Map<String, dynamic> item in res['results']) {
      list.add(fromMap(item));
    }

    return list;
  }
}
