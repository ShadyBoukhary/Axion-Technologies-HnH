import 'package:flutter/material.dart';
import 'package:hnh/app/components/countdown.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/home/home_controller.dart';
import 'package:hnh/app/abstract/view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageView createState() => HomePageView(HomeController());
}

class HomePageView extends State<HomePage> implements View {
  HomeController _controller;

  HomePageView(this._controller) {
    WidgetsBinding.instance.addObserver(_controller);
  }

  void callHandler(Function fn) {
    setState(() {
      fn();
    });
  }

  // Menu items
  /*
    About
    Places/Lodging/Food
    Register for Race
    Event Schedule
    Maps/Routes
    User Avatar / Name
    Sponsors

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: HhDrawer(),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 5.0),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Text(
                    "BA",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: ListView(
          children: <Widget>[
            Countdown(),
          ],
        ));
  }
}
