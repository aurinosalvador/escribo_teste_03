import 'package:escribo_teste_03/widgets/header.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewSite extends StatelessWidget {
  const WebViewSite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        ///TODO: transformar em StreamBuilder
        body: Column(
          children: const <Widget>[
            Header(
              type: 'webview',
            ),
            Expanded(
              child: WebView(
                initialUrl: 'https://www.starwars.com/community',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
