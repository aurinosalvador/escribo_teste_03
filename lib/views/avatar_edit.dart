import 'package:escribo_teste_03/controllers/avatar_controller.dart';
import 'package:escribo_teste_03/models/avatar.dart';
import 'package:escribo_teste_03/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class AvatarEdit extends StatefulWidget {
  const AvatarEdit({Key? key}) : super(key: key);

  @override
  State<AvatarEdit> createState() => _AvatarEditState();
}

class _AvatarEditState extends State<AvatarEdit> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        ///TODO: transformar em StreamBuilder
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

  Future<void> saveAvatar() async {
    AvatarController avatarController = AvatarController();
    Avatar avatar = await avatarController.getAvatar();

    if (avatar.getId() > -1) {
      avatar.setAvatar(await FluttermojiFunctions().encodeMySVGtoString());
      await avatarController.updateAvatar(avatar);
    } else {
      //insert
      avatar.setId(1);
      avatar.setAvatar(await FluttermojiFunctions().encodeMySVGtoString());
      await avatarController.insertAvatar(avatar);
    }
  }

  @override
  void dispose() {
    saveAvatar();

    super.dispose();
  }
}
