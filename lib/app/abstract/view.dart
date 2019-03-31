import 'package:flutter/material.dart';
import 'package:hnh/app/components/hhDrawer.dart';

abstract class View<Page extends StatefulWidget> extends State<Page> {
  static final HhDrawer drawer = HhDrawer();
  void callHandler(Function fn, {Map<String, dynamic> params}) {
    setState(() {
      print('refresh');
      if (params == null) {
        fn();
      } else {
        fn(params);
      }
    });
  }
}