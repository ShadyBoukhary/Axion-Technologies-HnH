import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatelessWidget {

  final String title;
  final String url;

  WebPage({Key key, @required this.title, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        body: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted));
  }

  AppBar get appBar => AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      );
}
