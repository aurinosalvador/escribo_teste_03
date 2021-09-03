import 'package:escribo_teste_03/models/abstract_model.dart';
import 'package:flutter/material.dart';

abstract class ApiModel extends AbstractModel {
  bool favorite;

  ApiModel(int id, String description, this.favorite) : super(id, description);

  @override
  bool get favoriteType => false;

  @override
  bool get fav => favorite;

  @override
  Color get borderColor => Colors.black;
}
