import 'package:escribo_teste_03/controllers/movie_controller.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Star Wars Favorites'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              Text('Home Page'),
              ElevatedButton(
                onPressed: () async {
                  MovieController movieController = MovieController();
                  List<Movie> movies = await movieController.listMovies();

                  for (Movie movie in movies) {
                    print('id: ${movie.id} title: ${movie.title}');
                  }
                },
                child: const Text('Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
