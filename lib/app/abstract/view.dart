import 'package:flutter/material.dart';

abstract class View<Page extends StatefulWidget> extends State<Page> {
  void callHandler(Function fn, {Map<String, dynamic> params}) {
    setState(() {
      if (params == null) {
        fn();
      } else {
        fn(params);
      }
    });
  }
}