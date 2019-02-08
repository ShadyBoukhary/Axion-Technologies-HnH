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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          elevation: 8.0,
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
                  radius: 15.0,
                  backgroundColor: Colors.red,
                  child: Text(
                    "BA",
                    style: TextStyle(
                        fontSize: 16.0,
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
            SizedBox(height: 60.0),
            Container(
              width: double.infinity,
              height: 200.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image(
                  image: AssetImage('assets/img/logo.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Text(
                            "HELL",
                            style: TextStyle(
                              color: Colors.red[800],
                              fontSize: 88.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 15.0,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(0.0, 5.0),
                                  blurRadius: 3.0,
                                  color: Colors.black,
                                ),
                                Shadow(
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "The Centennial \nRide From",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 3.0,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 3.0),
                                blurRadius: 3.0,
                                color: Colors.black,
                              ),
                              Shadow(
                                offset: Offset(0.0, 5.0),
                                blurRadius: 8.0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Countdown(),
          ],
        ));
  }
}
