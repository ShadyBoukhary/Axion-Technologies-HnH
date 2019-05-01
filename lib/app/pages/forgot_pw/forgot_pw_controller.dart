import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hnh/app/pages/forgot_pw/forgot_pw_presenter.dart';
class ForgotPwController extends Controller {
  TextEditingController email;
  ForgotPwPresenter _forgotPwPresenter;
  ForgotPwController(authRepo) {
    email = TextEditingController();
    _forgotPwPresenter = ForgotPwPresenter(authRepo);
    initListeners();
  }

  void initListeners() {
    _forgotPwPresenter.forgotOnComplete = () {
      dismissLoading();
      showGenericSnackbar(getScaffoldKey(), 'Email has been send!');
      Navigator.of(getContext()).pop();
    };

    _forgotPwPresenter.forgotOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getScaffoldKey(), e.message, isError: true);
    };
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];

    // Validate params
    assert(formKey is GlobalKey<FormState>);

    if (formKey.currentState.validate()) {
      resumeLoading();
      _forgotPwPresenter.forgotPassword(email: email.text);
    } else {
      showGenericSnackbar(getScaffoldKey(), Strings.registrationFormIncomplete, isError: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  

}
