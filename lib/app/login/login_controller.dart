
// Standard controller style

// import 'package:hnh/app/abstract/controller.dart';
// class LoginController extends Controller { 
//   LoginController() {
//     initListeners();
//   }
//   void initListeners() {
//   }
// }

import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/login/login_presenter.dart';
import 'package:flutter/material.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/app/main.dart';
// import 'package:hnh/data/repositories/data_user_repository.dart';
// import 'package:hnh/domain/entities/user.dart';

class LoginController extends Controller {

  String _userEmail;
  String _userPassword;
  dynamic _context;

  LoginPresenter _loginPresenter;
  // DataUserRepository _dataUserRepository;
  
  LoginController() {
    _loginPresenter = LoginPresenter(DataAuthenticationRepository());
    _userEmail = 'test@test.com';
    _userPassword = 'shady';

    initListeners();
  }

  /// Initializes [Presenter] listeners
  void initListeners() {
    _loginPresenter.loginOnComplete = this._loginOnComplete;
    _loginPresenter.loginOnError = this._loginOnError;
  }

  void _register() {
    
  }

  /// Login is successful
  void _loginOnComplete() {
    // TODO: Dismiss any loading events then navigate
    Navigator.of(_context).pushReplacementNamed('/home');
  }
  
  void _loginOnError(e) {
    // TODO: Handle the login error by maybe displaying a notifcation to the user
    // TODO: use `e.message` to retrieve the error message and display it
    // TODO: Delete print statement
    print(e.message);
  }

  /// Logs a [User] into the application
  void login(context) {
    _context = context;
    // TODO: Present some kind of loading when logging in
    _loginPresenter.login(email: _userEmail, password: _userPassword);
  }

  void _forgotPassword() {

  }
}