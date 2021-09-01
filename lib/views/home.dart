import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Star Wars Favorites'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text('Home Page'),
              ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse('https://swapi.dev/api/people');

                  Response response = await get(url);

                  Map<String, dynamic> res = jsonDecode(response.body);

                  for (Map<String, dynamic> people in res['results']) {
                    // print(getId.firstMatch(people['url'])!.group(1));
                  }
                },
                child: const Text('Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
