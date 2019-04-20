import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/app/pages/login/login_controller.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hnh/app/components/inputField.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/app/components/ensure_focus.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageView createState() => LoginPageView(LoginController());
}

class LoginPageView extends View<LoginPage> {
  static const String emailPrompt = 'Email Address';
  static const String passwordPrompt = 'Password';
  static const String loginButtonText = 'Sign In';
  static const String forgotPassswordButtonText = 'Forgot password?';
  static const String registerButtonText = 'No account? Create one.';

  LoginController _controller;
  final FocusNode _emailFocus;
  final FocusNode _passFocus;

  LoginPageView(this._controller)
      : _emailFocus = FocusNode(),
        _passFocus = FocusNode() {
    _controller.initController(scaffoldKey, callHandler);
  }

  @override
  Widget build(BuildContext context) {
    // ModalProgressHUD wraps the entire body with a loading using the controller.isLoading
    return Scaffold(
        key: scaffoldKey,
        body: ModalProgressHUD(
            child: body,
            inAsyncCall: _controller.isLoading,
            color: UIConstants.progressBarColor,
            opacity: UIConstants.progressBarOpacity));
  }

  // Scaffold body
  Stack get body => Stack(
        children: <Widget>[
          background,
          ListView(
            physics: PageScrollPhysics(),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 125.0, bottom: 10.0),
                          child: Image(
                            image: AssetImage(Resources.logo),
                            width: 200.0,
                          ),
                        ),
                        Text(
                          UIConstants.appName,
                          style: TextStyle(
                            color: Color.fromRGBO(230, 38, 39, 1.0),
                            fontSize: 32.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          emailField,
                          passwordField,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 45.0, vertical: 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[forgotPasswordButton],
                            ),
                          ),
                          SizedBox(height: 40.0),
                          loginButton,
                          SizedBox(height: 20.0),
                          registerButton
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );

  Widget get background => Positioned(
        top: 0.0,
        left: 0.0,
        right: 0.0,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          Resources.background,
          fit: BoxFit.cover,
        ),
      );

  // Fields and Buttons

  /// Email input field
  Widget get emailField => EnsureVisibleWhenFocused(
      child: InputField(
        _controller.emailTextController,
        emailPrompt,
        _emailFocus,
        type: TextInputType.emailAddress,
      ),
      focusNode: _emailFocus);

  /// Password input field
  Widget get passwordField => EnsureVisibleWhenFocused(
        child: InputField(
            _controller.passwordTextController, passwordPrompt, _passFocus,
            isPassword: true),
        focusNode: _passFocus,
      );

  GestureDetector get forgotPasswordButton => GestureDetector(
        onTap: () {},
        child: Text(
          forgotPassswordButtonText,
          style: new TextStyle(
            color: Color.fromRGBO(230, 38, 39, 0.8),
            fontSize: 14.0,
          ),
        ),
      );

  GestureDetector get loginButton => GestureDetector(
        onTap: () {
          callHandler(_controller.login);
        },
        child: Container(
          width: 320.0,
          height: 50.0,
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              color: Color.fromRGBO(230, 38, 39, 1.0),
              borderRadius: BorderRadius.circular(25.0)),
          child: Text(loginButtonText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.4)),
        ),
      );

  GestureDetector get registerButton => GestureDetector(
        onTap: _controller.register,
        child: Text(
          registerButtonText,
          style: TextStyle(
            color: Color.fromRGBO(230, 38, 39, 0.8),
            fontSize: 14.0,
          ),
        ),
      );
}
