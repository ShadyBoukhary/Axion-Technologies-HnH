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
        body: new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Image(
          image: new AssetImage('assets/img/background.jpg'),
          fit: BoxFit.cover,
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image(
              image: new AssetImage('assets/img/logo.png'),
              width: 200.0,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: new Text(
                "Hotter'n Hell",
                style: new TextStyle(
                  color: Color.fromRGBO(230, 38, 39, 1.0),
                  fontSize: 32.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(
                  top: 200.0, left: 40.0, right: 40.0, bottom: 10.0),
              child: new Form(
                autovalidate: true,
                child: new TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.4))),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.4))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(230, 38, 39, 0.8))),
                    fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    filled: true,
                    hintText: "Email Address",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: 10.0, left: 40.0, right: 40.0),
              child: new Form(
                autovalidate: true,
                child: new TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.4))),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(255, 255, 255, 0.4))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(230, 38, 39, 0.8))),
                    fillColor: Color.fromRGBO(255, 255, 255, 0.4),
                    filled: true,
                    hintText: "Password",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: new Text(
                "Forgot password?",
                style: new TextStyle(
                  color: Color.fromRGBO(230, 38, 39, 0.8),
                  fontSize: 16.0,
                ),
              ),
            ),
            new Container(
              width: 320.0,
              height: 50.0,
              alignment: FractionalOffset.center,
              decoration: new BoxDecoration(
                  color: Color.fromRGBO(230, 38, 39, 1.0),
                  borderRadius: new BorderRadius.circular(25.0)),
              child: new Text("Sign In",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.4)),
            ),
          ],
        ),
      ],
    ));
  }
}
