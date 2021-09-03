import 'package:escribo_teste_03/models/favorite.dart';
import 'package:escribo_teste_03/models/movie.dart';
import 'package:escribo_teste_03/models/people.dart';
import 'package:flutter/material.dart';

class CardList<T> extends StatefulWidget {
  final T object;
  final Function? onTap;

  const CardList(this.object, {Key? key, this.onTap}) : super(key: key);

  @override
  State<CardList<T>> createState() => _CardListState<T>();
}

class _CardListState<T> extends State<CardList<T>> {
  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.black;
    String text;
    bool isFav = false;
    if (widget.object.runtimeType == Movie) {
      text = (widget.object as Movie).title;
      isFav = (widget.object as Movie).isFavorite();
    } else if (widget.object.runtimeType == People) {
      text = (widget.object as People).name;
      isFav = (widget.object as People).isFavorite();
    } else {
      text = (widget.object as Favorite).description;
      if ((widget.object as Favorite).type == 'movie') {
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
            if (widget.object.runtimeType != Favorite)
              GestureDetector(
                onTap: () => widget.onTap!(widget.object),
                child: Icon(isFav ? Icons.favorite : Icons.favorite_border),
              ),
          ],
        ),
      ),
    );
  }
}
