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

  final ScrollController _scrollController = ScrollController();

  final FavoriteController favoriteController = FavoriteController();

  final MovieController movieController = MovieController();

  List<Movie> movies = [];

  int page = 1;
  int totalPages = 1;

  bool isLoading = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
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

    if (movies.isEmpty) {
      movies = await movieController.list(page: page);
      totalPages = await movieController.getPagesNumber();
    } else {
      movies.addAll(await movieController.list(page: page));
    }

    for (Movie movie in movies) {
      movie.favorite =
          await favoriteController.verifyFavorite(movie.description, 'movie');
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

    if (movie.favorite) {
      await controller.deleteFavorite(movie.description, 'movie');
      movie.favorite = false;
    } else {
      Favorite favorite = Favorite(movie.id, movie.description, 'movie');
      await controller.insertFavorite(favorite);
      movie.favorite = true;
    }
    // setState(() {});
    _controller.add(MovieState.complete);
  }

  void goToPage(int page, int total) {
    // setState(() {
    this.page = page;
    totalPages = total;
    loadData(page);
    // });
    _controller.add(MovieState.complete);
  }

  @override
  void dispose() {
    _controller.close();
    _scrollController.dispose();
    super.dispose();
  }
}
