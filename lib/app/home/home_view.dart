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

  @override
  Widget build(BuildContext context) {
    var columnChildren = <Widget>[
      Text(
        'You have pushed the button this many times:',
      ),
      Text(
        "${_controller.counter}",
        style: Theme.of(context).textTheme.display1,
      ),
      RaisedButton(
        child: Text("Get User"),
        onPressed: () {
          callHandler(_controller.getUser);
        },
      ),
    ];
    if (!_controller.hidden) {
      columnChildren.add(Text('Name: ${_controller.currentUser?.firstName} ${_controller.currentUser?.lastName}'));
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: columnChildren
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callHandler(_controller.incrementCounter);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
