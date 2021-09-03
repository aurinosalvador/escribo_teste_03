import 'dart:ui';

import 'package:escribo_teste_03/models/abstract_model.dart';
import 'package:flutter/material.dart';

class Favorite extends AbstractModel {
  final String type;

  Favorite(int id, String description, this.type) : super(id, description);

  Favorite.fromMap(Map<String, dynamic> map)
      : type = map['type'],
        super(
          map['id'],
          map['description'],
        );

  @override
  bool get favoriteType => true;

  @override
  bool get fav => false;

  @override
  Color get borderColor => type == 'people' ? Colors.green : Colors.red;
}
