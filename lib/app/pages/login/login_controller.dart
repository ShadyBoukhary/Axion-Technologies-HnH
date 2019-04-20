import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:flutter/material.dart';
import 'package:hnh/app/pages/login/login_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';

class LoginController extends Controller {

  // Text Field controllers
  TextEditingController emailTextController;
  TextEditingController passwordTextController;

  LoginPresenter _loginPresenter;
  // DataUserRepository _dataUserRepository;
  
  LoginController() {
    _loginPresenter = LoginPresenter(DataAuthenticationRepository());
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    initListeners();
  }

  /// Initializes [Presenter] listeners
  void initListeners() {
    _loginPresenter.loginOnComplete = this._loginOnComplete;
    _loginPresenter.loginOnError = this._loginOnError;
  }

  /// Login is successful
  void _loginOnComplete() {
    dismissLoading();
    View.refreshDrawer();
    Navigator.of(getContext()).pushReplacementNamed('/home');
  }
  
  void _loginOnError(e) {
    dismissLoading();
    showGenericSnackbar(getScaffoldKey(), e.message, isError: true);
  }

  /// Logs a [User] into the application
  void login() async {
    resumeLoading();
    _loginPresenter.login(email: emailTextController.text, password: passwordTextController.text);
  }

  void register() {
    Navigator.of(getContext()).pushNamed('/register');
  }

  void _forgotPassword() {

  }
}