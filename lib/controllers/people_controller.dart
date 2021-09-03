import 'package:escribo_teste_03/controllers/api_controller.dart';
import 'package:escribo_teste_03/models/people.dart';

class PeopleController extends ApiController<People> {
  PeopleController() : super('people');

  @override
  People fromMap(Map<String, dynamic> map) => People.fromMap(map);
}
