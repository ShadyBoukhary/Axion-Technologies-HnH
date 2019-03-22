import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  WebPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WebPageView createState() => _WebPageView();
}

class _WebPageView extends View<WebPage> {

  WebViewController _controller;
  _WebPageView();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: WebView(
        initialUrl: 'https://www.hh100.org/sign-up',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
      ),
    );
  }

  AppBar get appBar => AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );


  @override
  void dispose() {
    super.dispose();
  }
}
