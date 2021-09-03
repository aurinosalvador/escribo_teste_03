import 'dart:async';

import 'package:escribo_teste_03/controllers/favorite_controller.dart';
import 'package:escribo_teste_03/controllers/movie_controller.dart';
import 'package:escribo_teste_03/models/favorite.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:escribo_teste_03/widgets/card_list.dart';
import 'package:flutter/material.dart';

enum MovieState {
  loading,
  complete,
}

class MovieContent extends StatefulWidget {
  const MovieContent({Key? key}) : super(key: key);

  @override
  State<MovieContent> createState() => _MovieContentState();
}

class _MovieContentState extends State<MovieContent> {
  final StreamController<MovieState> _controller =
      StreamController<MovieState>();
  late ScrollController _scrollController;

  List<Movie> movies = [];

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
    _controller.add(MovieState.loading);
    isLoading = true;

    MovieController movieController = MovieController();
    if (movies.isEmpty) {
      movies = await movieController.listMovies(page: page);
      totalPages = await movieController.getPagesNumber();
    } else {
      movies.addAll(await movieController.listMovies(page: page));
    }

    FavoriteController favoriteController = FavoriteController();
    for (Movie movie in movies) {
      bool isFav = await favoriteController.verifyFavorite(movie.title);

      movie.setFavorite(isFav);
    }

    this.page++;
    isLoading = false;
    _controller.add(MovieState.complete);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieState>(
      stream: _controller.stream,
      initialData: MovieState.loading,
      builder: (BuildContext context, AsyncSnapshot<MovieState> snapshot) {
        if (movies.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: movies.length,
                    itemBuilder: (BuildContext context, int index) {
                      Movie movie = movies.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardList<Movie>(movie, onTap: toogleFavorite),
                      );
                    },
                  ),
                ),
              ),
              if (snapshot.data == MovieState.loading)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const CircularProgressIndicator(),
                ),
            ],
          );
        } else {
          if (snapshot.data == MovieState.complete) {
            return const Center(
              child: Text('Sem Filmes'),
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

  void toogleFavorite(Movie movie) async {
    FavoriteController controller = FavoriteController();

    if (movie.isFavorite()) {
      await controller.deleteFavorite(movie.title);
      movie.setFavorite(false);
    } else {
      Favorite favorite = Favorite(movie.id, movie.title, 'movie');
      await controller.insertFavorite(favorite);
      movie.setFavorite(true);
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
