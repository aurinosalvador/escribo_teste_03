import 'package:escribo_teste_03/controllers/avatar_controller.dart';
import 'package:escribo_teste_03/models/avatar.dart';
import 'package:escribo_teste_03/views/avatar_edit.dart';
import 'package:escribo_teste_03/views/home.dart';
import 'package:escribo_teste_03/views/webview_site.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class Header extends StatefulWidget {
  final String? type;

  const Header({Key? key, this.type}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    loadAvatar();

    super.initState();
  }

  Future<void> loadAvatar() async {
    AvatarController avatarController = AvatarController();
    Avatar avatar = await avatarController.getAvatar();

    if (avatar.getId() > -1) {
      FluttermojiFunctions().decodeFluttermojifromString(avatar.getAvatar());
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isWebView = false;
    bool isAvatarView = false;

    if (widget.type != null && widget.type!.isNotEmpty) {
      if (widget.type!.toLowerCase().trim() == 'webview') {
        isWebView = true;
      } else if (widget.type!.toLowerCase().trim() == 'avatarview') {
        isAvatarView = true;
      }
    }

    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ///Site Oficial
            TextButton(
              onPressed: () {
                isWebView
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const Home(),
                        ),
                      )
                    : Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const WebViewSite(),
                        ),
                      );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    transform: Matrix4.skewX(-0.5)..translate(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      color: isWebView ? Colors.lightBlue : Colors.transparent,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 50.0,
                    ),
                    margin: const EdgeInsets.only(left: 8.0),
                  ),
                  const Text(
                    'Site Oficial',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            ///Avatar
            GestureDetector(
              onTap: () {
                isAvatarView
                    ? Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const Home(),
                        ),
                      )
                    : Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const AvatarEdit(),
                        ),
                      );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isAvatarView ? Colors.lightBlue : Colors.transparent,
                ),
                padding: const EdgeInsets.all(1.0),
                child: FluttermojiCircleAvatar(radius: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
