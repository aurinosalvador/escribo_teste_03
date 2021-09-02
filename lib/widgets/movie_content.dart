import 'dart:async';

import 'package:escribo_teste_03/controllers/movie_controller.dart';
import 'package:escribo_teste_03/models/movie.dart';
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

  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    MovieController movieController = MovieController();
    movies = await movieController.listMovies();
    _controller.add(MovieState.complete);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieState>(
      stream: _controller.stream,
      initialData: MovieState.loading,
      builder: (BuildContext context, AsyncSnapshot<MovieState> snapshot) {
        if (snapshot.hasData && snapshot.data == MovieState.complete) {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(movies.elementAt(index).title),
                trailing: GestureDetector(
                  onTap: () => print('Favoritar'),
                  child: const Icon(Icons.favorite_border),
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
