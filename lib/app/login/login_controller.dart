
// Standard controller style

// import 'package:hnh/app/abstract/controller.dart';
// class LoginController extends Controller { 
//   LoginController() {
//     _initListeners();
//   }
//   void _initListeners() {
//   }
// }

import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/login/login_presenter.dart';
// import 'package:hnh/data/repositories/data_user_repository.dart';
// import 'package:hnh/domain/entities/user.dart';

class LoginController extends Controller {

  String _userEmail;
  String _userPassword;

  LoginPresenter _loginPresenter;
  // DataUserRepository _dataUserRepository;
  
  LoginController() {
    _userEmail = "";
    _userPassword = "";

    _initListeners();
  }

  void _initListeners() {

  }

  void _register() {

  }

  void _login() {

  }

  void _forgotPassword() {

  }

}
