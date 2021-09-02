import 'package:flutter/material.dart';

class CustomPagination extends StatelessWidget {
  int page;
  int totalPages;
  Function onPressed;

  CustomPagination({
    Key? key,
    required this.page,
    required this.totalPages,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        /// Move to initial Page
        ElevatedButton(
          onPressed: page != 1
              ? () {
                  page = 1;
                  onPressed(page, totalPages);
                }
              : null,
          child: const Text('<<'),
        ),

        /// Move to pev Page
        ElevatedButton(
          onPressed: page != 1
              ? () {
                  page--;
                  onPressed(page, totalPages);
                }
              : null,
          child: const Text('<'),
        ),

        /// Info
        Text('$page de $totalPages'),

        /// Move to next Page
        ElevatedButton(
          onPressed: page != totalPages
              ? () {
                  page++;
                  onPressed(page, totalPages);
                }
              : null,
          child: const Text('>'),
        ),

        /// Move to last Page
        ElevatedButton(
          onPressed: page != totalPages
              ? () {
                  page = totalPages;
                  onPressed(page, totalPages);
                }
              : null,
          child: const Text('>>'),
        ),
      ],
    );
  }
}
