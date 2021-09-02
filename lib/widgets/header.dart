import 'package:escribo_teste_03/views/webview_site.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class Header extends StatelessWidget {
  final String? type;

  const Header({Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isWebView = false;
    bool isAvatarView = false;

    if (type != null && type!.isNotEmpty) {
      if (type!.toLowerCase().trim() == 'webview') {
        isWebView = true;
      } else if (type!.toLowerCase().trim() == 'avatarview') {
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
                    ? Navigator.of(context).pop()
                    : Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const WebViewSite(),
                        ),
                      );
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                color: isWebView ? Colors.lightBlue : Colors.transparent,
                child: Text(
                  'Site Oficial',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: isWebView
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),

            ///Avatar
            FluttermojiCircleAvatar(radius: 25),
          ],
        ),
      ),
    );
  }
}