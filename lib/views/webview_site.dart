import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewSite extends StatelessWidget {
  const WebViewSite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://www.starwars.com/community',
    );
  }
}