import 'package:escribo_teste_03/widgets/header.dart';
import 'package:escribo_teste_03/widgets/movie_content.dart';
import 'package:escribo_teste_03/widgets/people_content.dart';
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
                    MovieContent(),
                    PeopleContent(),
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
