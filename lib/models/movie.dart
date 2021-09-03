import 'package:escribo_teste_03/models/api_model.dart';

class Movie extends ApiModel {
  Movie.fromMap(Map<String, dynamic> map)
      : super(
          int.tryParse(Uri.parse(map['url'])
                  .pathSegments
                  .lastWhere((String path) => path.isNotEmpty)) ??
              -1,
          map['title'],
          false,
        );
}
