import 'dart:async';

import 'package:escribo_teste_03/controllers/favorite_controller.dart';
import 'package:escribo_teste_03/controllers/people_controller.dart';
import 'package:escribo_teste_03/models/favorite.dart';
import 'package:escribo_teste_03/models/people.dart';
import 'package:escribo_teste_03/widgets/card_list.dart';
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
  late ScrollController _scrollController;

  List<People> peoples = [];

  int page = 1;
  int totalPages = 1;

  bool isLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_scrollListener);
    loadData(page);

    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (page <= totalPages && !isLoading) {
        loadData(page);
      }
    }
  }

  Future<void> loadData(int page) async {
    _controller.add(PeopleState.loading);
    isLoading = true;

    PeopleController peopleController = PeopleController();
    if (peoples.isEmpty) {
      peoples = await peopleController.listPeoples(page: page);
      totalPages = await peopleController.getPagesNumber();
    } else {
      peoples.addAll(await peopleController.listPeoples(page: page));
    }

    FavoriteController favoriteController = FavoriteController();
    for (People people in peoples) {
      bool isFav = await favoriteController.verifyFavorite(people.name);

      people.setFavorite(isFav);
    }

    this.page++;
    isLoading = false;
    _controller.add(PeopleState.complete);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PeopleState>(
      stream: _controller.stream,
      initialData: PeopleState.loading,
      builder: (BuildContext context, AsyncSnapshot<PeopleState> snapshot) {
        if (peoples.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: peoples.length,
                    itemBuilder: (BuildContext context, int index) {
                      People people = peoples.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardList<People>(people, onTap: toogleFavorite),
                      );
                    },
                  ),
                ),
              ),
              if (snapshot.data == PeopleState.loading)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const CircularProgressIndicator(),
                ),
            ],
          );
        } else {
          if (snapshot.data == PeopleState.complete) {
            return const Center(
              child: Text('Sem Personagens'),
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
        }
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
