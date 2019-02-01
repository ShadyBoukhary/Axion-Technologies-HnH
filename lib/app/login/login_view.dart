import 'package:flutter/material.dart';
import 'package:hnh/app/login/login_controller.dart';
import 'package:hnh/app/abstract/view.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageView createState() => LoginPageView(LoginController());
}

class LoginPageView extends State<LoginPage> implements View {
  LoginController _controller;

  LoginPageView(this._controller);

  void callHandler(Function fn) {
    setState(() {
      fn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(decoration: InputDecoration(labelText: "Password"))
          ]),
        ),
      ),
    );
  }
}
