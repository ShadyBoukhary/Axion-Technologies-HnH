import 'package:flutter/material.dart';
import 'package:hnh/app/components/hhDrawer/hhDrawerView.dart';

abstract class View<Page extends StatefulWidget> extends State<Page> {
  static HhDrawer drawer = HhDrawer();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  /// Refreshes the drawer to accomodate a change in the user.
  static void refreshDrawer() {
    drawer = HhDrawer();
  }

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