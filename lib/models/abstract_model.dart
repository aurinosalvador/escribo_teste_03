import 'dart:ui';

abstract class AbstractModel {
  final int id;
  final String description;

  AbstractModel(this.id, this.description);

  bool get favoriteType;

  bool get fav;

  Color get borderColor;
}
