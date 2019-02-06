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
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  "Brice Allard",
                  style: TextStyle(fontSize: 20.0),
                ),
                accountEmail: Text(
                  "briceallard@gmail.com",
                  style: TextStyle(fontSize: 12.0),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () => print("This is the current user"),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.briceallard.com/static/img/logo-main.ef47e8a.png'),
                  ),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/drawer_bg.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop)),
                ),
              ),
              ListTile(
                title: Text(
                  "Schedule",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.calendar_today),
              ),
              ListTile(
                title: Text(
                  "Registration",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.class_),
              ),
              ListTile(
                title: Text(
                  "Lodging",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.hotel),
              ),
              ListTile(
                title: Text(
                  "Dining",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.local_dining),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Sponsors",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.people),
              ),
              ListTile(
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.info),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Settings",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.settings),
              ),
              ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                ),
                trailing: Icon(Icons.exit_to_app),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Hotter'n Hell Hundred",
                style: TextStyle(color: Colors.white),
              ),
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
            
          ],
        ));
  }
}
