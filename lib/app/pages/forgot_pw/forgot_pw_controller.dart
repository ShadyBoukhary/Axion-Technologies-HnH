import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:flutter/material.dart';

class ForgotPwController extends Controller {
  TextEditingController email;

  GlobalKey<ScaffoldState> _scaffoldKey;

  ForgotPwController(authRepo) {
    email = TextEditingController();

    initListeners();
  }

  void initListeners() {

  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];
    _scaffoldKey = params['scaffoldKey'];

    // Validate params
    assert(formKey is GlobalKey<FormState>);
    assert(_scaffoldKey is GlobalKey<ScaffoldState>);

    if (formKey.currentState.validate()) {
      logger.shout('Registration successful');
      showGenericSnackbar(_scaffoldKey, Strings.forgotEmailSent, isError: false);
    } else {
      logger.shout('Registration failed');
      showGenericSnackbar(_scaffoldKey, Strings.registrationFormIncomplete, isError: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  

}
