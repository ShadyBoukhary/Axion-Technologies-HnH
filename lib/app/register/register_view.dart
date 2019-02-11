import 'package:flutter/material.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/register/register_controller.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageView createState() => _RegisterPageView(RegisterController());
}

class _RegisterPageView extends State<RegisterPage> implements View {
  RegisterController _controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _RegisterPageView(this._controller);

  void callHandler(Function fn, {Map<String, dynamic> params}) {
    setState(() {
      if (params.isEmpty) {
        fn();
      } else {
        fn(params);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('New User Registration'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'First name is required.';
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Last name is required.';
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Email address is required.';
                      }
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Password is required.';
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: _controller.agreedToTOS,
                          onChanged: (state) {
                            callHandler(_controller.setAgreedToTOS);
                          },
                          activeColor: Colors.red,
                        ),
                        GestureDetector(
                          onTap: () => () {
                                callHandler(_controller.setAgreedToTOS);
                              },
                          child: Text(
                            'I agree to the Terms of Services and Privacy Policy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // TODO: Open the TOS for view
                        },
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => callHandler(_controller.checkForm, params: {'context': context, 'formKey': _formKey, 'scaffoldKey': _scaffoldKey}),
                        child: Container(
                          width: 320.0,
                          height: 50.0,
                          alignment: FractionalOffset.center,
                          decoration: new BoxDecoration(
                              color: Color.fromRGBO(230, 38, 39, 1.0),
                              borderRadius: new BorderRadius.circular(25.0)),
                          child: new Text("Register",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 0.4)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
