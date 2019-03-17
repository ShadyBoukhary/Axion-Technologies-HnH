import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/login/login_presenter.dart';
import 'package:flutter/material.dart';
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
    isLoading = false;

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
    Navigator.of(context).pushReplacementNamed('/home');
  }
  
  void _loginOnError(e) {
    // TODO: Handle the login error by maybe displaying a notifcation to the user
    // TODO: use `e.message` to retrieve the error message and display it
    // TODO: Delete print statement
    dismissLoading();
    print(e.message);
  }

  /// Logs a [User] into the application
  void login() async {
    isLoading = true;
   // await DataAuthenticationRepository().isAuthenticated();
    // TODO: Present some kind of loading when logging in
    _loginPresenter.login(email: emailTextController.text, password: passwordTextController.text);
  }

  void register() {
    Navigator.of(context).pushNamed('/register');
  }

  void _forgotPassword() {

  }
}