import 'package:escribo_teste_03/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class AvatarEdit extends StatelessWidget {
  const AvatarEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const Header(type: 'avatarview'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FluttermojiCircleAvatar(radius: 80),
            ),
            Expanded(
              child: FluttermojiCustomizer(
                outerTitleText: 'Personalize seu Avatar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
