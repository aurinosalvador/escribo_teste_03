import 'package:escribo_teste_03/controllers/movie_controller.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:escribo_teste_03/views/webview_site.dart';
import 'package:escribo_teste_03/widgets/header.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              const Header(),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
