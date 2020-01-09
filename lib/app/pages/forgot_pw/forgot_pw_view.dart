import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/forgot_pw/forgot_pw_controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ForgotPwPage extends View {
  ForgotPwPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgotPwPageView createState() => _ForgotPwPageView();
}

class _ForgotPwPageView extends ViewState<ForgotPwPage, ForgotPwController> {
  ForgotPwController _controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _ForgotPwPageView()
      : super(ForgotPwController(DataAuthenticationRepository()));

  @override
  Widget buildPage() {
    return ModalProgressHUD(
        child: body,
        inAsyncCall: _controller.isLoading,
        color: UIConstants.progressBarColor,
        opacity: UIConstants.progressBarOpacity);
  }

  Widget get body => Scaffold(
        key: globalKey,
        appBar: appBar,
        body: Stack(
          children: <Widget>[
            background,
            ListView(
              children: <Widget>[
                SizedBox(height: 20.0),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Text(
                        Strings.forgotPwInstructions,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _controller.email,
                          keyboardType: TextInputType.emailAddress,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RawMaterialButton(
                              onPressed: () => _controller.checkForm({
                                'formKey': _formKey,
                              }),
                              child: Container(
                                width: 320.0,
                                height: 50.0,
                                alignment: FractionalOffset.center,
                                decoration: new BoxDecoration(
                                    color: Color.fromRGBO(230, 38, 39, 1.0),
                                    borderRadius:
                                        new BorderRadius.circular(25.0)),
                                child: new Text("Reset Password",
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
          ],
        ),
      );

  AppBar get appBar => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Reset Account Password',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            )),
      );

  Widget get background => Positioned.fill(
        child: Image.asset(
          Resources.background,
          fit: BoxFit.cover,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
