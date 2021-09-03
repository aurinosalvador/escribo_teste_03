import 'package:escribo_teste_03/models/favorite.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:escribo_teste_03/models/people.dart';
import 'package:flutter/material.dart';

class CardList<T> extends StatelessWidget {
  final T object;
  final Function? onTap;

  const CardList(this.object, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.black;
    String text;
    bool isFav = false;
    if (object.runtimeType == Movie) {
      text = (object as Movie).title;
      isFav = (object as Movie).isFavorite();
    } else if (object.runtimeType == People) {
      text = (object as People).name;
      isFav = (object as People).isFavorite();
    } else {
      text = (object as Favorite).description;
      if ((object as Favorite).type == 'movie') {
        borderColor = Colors.red;
      } else {
        borderColor = Colors.green;
      }
    }

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: borderColor,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
            if (object.runtimeType != Favorite)
              GestureDetector(
                onTap: () => onTap!(object),
                child: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              ),
          ],
        ),
      ),
    );
  }
}
