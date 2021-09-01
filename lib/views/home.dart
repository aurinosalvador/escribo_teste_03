import 'package:escribo_teste_03/controllers/movie_controller.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Star Wars Favorites'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: const TabBar(
                  indicatorColor: Colors.greenAccent,
                  tabs: <Tab>[
                    Tab(text: 'Filmes'),
                    Tab(text: 'Personagens'),
                    Tab(text: 'Favoritos'),
                  ],
                ),
              ),
              const Expanded(
                  child: TabBarView(
                children: <Widget>[
                  Text('Teste'),
                  Text('Teste2'),
                  Text('Teste3'),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
