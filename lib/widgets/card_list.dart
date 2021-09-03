import 'package:escribo_teste_03/models/abstract_model.dart';
import 'package:flutter/material.dart';

class CardList<T extends AbstractModel> extends StatelessWidget {
  final T model;
  final Function? onTap;

  const CardList(this.model, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: model.borderColor,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: model.favoriteType
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.description,
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
            if (!model.favoriteType)
              IconButton(
                icon: Icon(model.fav ? Icons.favorite : Icons.favorite_border),
                onPressed: onTap == null ? null : () => onTap!(model),
              ),
          ],
        ),
      ),
    );
  }
}
