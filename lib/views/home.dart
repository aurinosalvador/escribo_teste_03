import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Star Wars Favorites'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Home Page'),
        ),
      ),
    );
  }
}
