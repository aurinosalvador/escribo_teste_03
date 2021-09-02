import 'dart:async';

import 'package:escribo_teste_03/controllers/movie_controller.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:escribo_teste_03/widgets/custom_pagination.dart';
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

  int page = 1;
  int totalPages = 1;

  @override
  void initState() {
    loadData(page);

    super.initState();
  }

  Future<void> loadData(int page) async {
    _controller.add(MovieState.loading);

    MovieController movieController = MovieController();
    movies = await movieController.listMovies(page: page);
    totalPages = await movieController.getPagesNumber();

    _controller.add(MovieState.complete);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieState>(
      stream: _controller.stream,
      initialData: MovieState.loading,
      builder: (BuildContext context, AsyncSnapshot<MovieState> snapshot) {
        if (snapshot.hasData && snapshot.data == MovieState.complete) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
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
