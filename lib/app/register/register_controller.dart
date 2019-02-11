import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/app/register/register_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class RegisterController extends Controller {
  String _firstName;
  String _lastName;
  String _userEmail;
  String _userPassword;

  Logger logger;
  dynamic _context;
  bool agreedToTOS;

  AuthenticationRepository _authenticationRepository;
  RegisterPresenter _registerPresenter;

  RegisterController() {
    // _authenticationRepository = AuthenticationRepository();
    _registerPresenter = RegisterPresenter(_authenticationRepository);
    _firstName = '';
    _lastName = '';
    _userEmail = '';
    _userPassword = '';
    agreedToTOS = false;
    logger = Logger('RegisterController');

    initListeners();
  }

  void initListeners() {
    _registerPresenter.registerOnComplete = () {
      logger.finest("Complete: Registration success.");
    };

    _registerPresenter.registerOnError = () {
      logger.shout("ERROR: Registration failed.");
    };
  }

  void register(context) {
    _context = context;

    _registerPresenter.register(
        firstName: _firstName,
        lastName: _lastName,
        email: _userEmail,
        password: _userPassword);
  }

  void setAgreedToTOS() {
    agreedToTOS = !agreedToTOS;
  }

  void checkForm(Map<String, dynamic> params) {
    _context = params['context'];
    dynamic formKey = params['formKey'];
    dynamic scaffoldKey = params['scaffoldKey'];

    // Validate params
    assert(_context is BuildContext);
    assert(formKey is GlobalKey<FormState>);
    assert(scaffoldKey is GlobalKey<ScaffoldState>);

    final snackBar = SnackBar(
      content: Text(
        'Form must be filled out and TOS accepted.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16.0,
        ),
      ),
    );

    if (formKey.currentState.validate()) {
      if (agreedToTOS) {
        logger.finest('Registration send successful');
        Navigator.of(_context).pop();
        register(_context);
      }
    } else {
      logger.shout('Registration failed');
      scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
}
