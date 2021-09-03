import 'dart:async';

import 'package:escribo_teste_03/controllers/favorite_controller.dart';
import 'package:escribo_teste_03/controllers/people_controller.dart';
import 'package:escribo_teste_03/models/favorite.dart';
import 'package:escribo_teste_03/models/people.dart';
import 'package:escribo_teste_03/widgets/custom_pagination.dart';
import 'package:flutter/material.dart';

enum PeopleState {
  loading,
  complete,
}

class PeopleContent extends StatefulWidget {
  const PeopleContent({Key? key}) : super(key: key);

  @override
  State<PeopleContent> createState() => _PeopleContentState();
}

class _PeopleContentState extends State<PeopleContent> {
  final StreamController<PeopleState> _controller =
      StreamController<PeopleState>();

  List<People> peoples = [];

  int page = 1;
  int totalPages = 1;

  @override
  void initState() {
    loadData(page);

    super.initState();
  }

  Future<void> loadData(int page) async {
    _controller.add(PeopleState.loading);

    PeopleController peopleController = PeopleController();
    peoples = await peopleController.listPeoples(page: page);
    totalPages = await peopleController.getPagesNumber();

    FavoriteController favoriteController = FavoriteController();
    for (People people in peoples) {
      bool isFav = await favoriteController.verifyFavorite(people.name);

      people.setFavorite(isFav);
    }

    _controller.add(PeopleState.complete);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PeopleState>(
      stream: _controller.stream,
      initialData: PeopleState.loading,
      builder: (BuildContext context, AsyncSnapshot<PeopleState> snapshot) {
        if (snapshot.hasData && snapshot.data == PeopleState.complete) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: peoples.length,
                  itemBuilder: (BuildContext context, int index) {
                    People people = peoples.elementAt(index);
                    return ListTile(
                      title: Text(people.name),
                      trailing: GestureDetector(
                        onTap: () => toogleFavorite(people),
                        child: Icon(people.isFavorite()
                            ? Icons.favorite
                            : Icons.favorite_border),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomPagination(
                  page: page,
                  totalPages: totalPages,
                  onPressed: goToPage,
                ),
              ),
            ],
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

  void toogleFavorite(People people) async {
    FavoriteController controller = FavoriteController();

    if (people.isFavorite()) {
      await controller.deleteFavorite(people.name);
      people.setFavorite(false);
    } else {
      Favorite favorite = Favorite(people.id, people.name, 'people');
      await controller.insertFavorite(favorite);
      people.setFavorite(true);
    }
    setState(() {});

    print('favorite');
  }

  void goToPage(int page, int total) {
    setState(() {
      this.page = page;
      totalPages = total;

      loadData(page);
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
