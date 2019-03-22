import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {
  WebPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: WebView(
            initialUrl: 'https://www.hh100.org/sign-up',
            javascriptMode: JavascriptMode.unrestricted));
  }

  AppBar get appBar => AppBar(
        title: Text(
          'Registration',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      );
}
