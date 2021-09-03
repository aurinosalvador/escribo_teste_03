import 'dart:async';

import 'package:escribo_teste_03/controllers/favorite_controller.dart';
import 'package:escribo_teste_03/models/favorite.dart';
import 'package:flutter/material.dart';

enum FavoriteState {
  loading,
  complete,
}

class FavoriteContent extends StatefulWidget {
  const FavoriteContent({Key? key}) : super(key: key);

  @override
  State<FavoriteContent> createState() => _FavoriteContentState();
}

class _FavoriteContentState extends State<FavoriteContent> {
  final StreamController<FavoriteState> _controller =
      StreamController<FavoriteState>();

  List<Favorite> favorites = [];

  @override
  void initState() {
    loadData();

    super.initState();
  }

  Future<void> loadData() async {
    _controller.add(FavoriteState.loading);

    FavoriteController favoriteController = FavoriteController();
    favorites = await favoriteController.getFavorites();

    _controller.add(FavoriteState.complete);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FavoriteState>(
      stream: _controller.stream,
      initialData: FavoriteState.loading,
      builder: (BuildContext context, AsyncSnapshot<FavoriteState> snapshot) {
        if (snapshot.hasData && snapshot.data == FavoriteState.complete) {
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              Favorite favorite = favorites.elementAt(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color:
                          favorite.type == 'movie' ? Colors.red : Colors.green,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      favorite.description,
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: CircularProgressIndicator(),
            ),
            Text('Aguarde...'),
          ],
        );
      },
    );
  }
}
