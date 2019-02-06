import 'package:flutter/material.dart';
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          // Here we take the value from the HomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Hotter'n Hell Hundred"),
          backgroundColor: Colors.white54,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    "Home Page",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {
                      _controller.logout(context);
                    },
                    elevation: 20.0,
                    color: Colors.red,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
