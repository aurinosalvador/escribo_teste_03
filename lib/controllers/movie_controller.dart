import 'package:escribo_teste_03/controllers/api_controller.dart';
import 'package:escribo_teste_03/models/movie.dart';

class MovieController extends ApiController<Movie> {
  MovieController() : super('films');

  @override
  Movie fromMap(Map<String, dynamic> map) => Movie.fromMap(map);
}
