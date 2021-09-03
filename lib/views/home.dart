import 'package:escribo_teste_03/controllers/favorite_controller.dart';
import 'package:escribo_teste_03/models/favorite.dart';
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
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    const MovieContent(),
                    const PeopleContent(),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              FavoriteController favoriteController =
                                  FavoriteController();

                              favoriteController.getFavorites();
                            },
                            child: Text('Get'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              FavoriteController favoriteController =
                                  FavoriteController();

                              Favorite favorite = Favorite(1, 'Teste', 'movie');

                              favoriteController.insertFavorite(favorite);
                            },
                            child: Text('Insert'),
                          ),
                        ],
                      ),
                    ),
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
