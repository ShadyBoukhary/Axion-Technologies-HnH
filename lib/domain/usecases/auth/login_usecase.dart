import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:logging/logging.dart';

/// A `UseCase` for logging in a `User` into the application
class LoginUseCase extends CompletableUseCase<LoginUseCaseParams> {
  // Members
  AuthenticationRepository _authenticationRepository;
  Logger _logger;
  // Constructors
  LoginUseCase(this._authenticationRepository) : super() {
    _logger = Logger('LoginUseCase');
  }

  @override
  Future<Stream<User>> buildUseCaseStream(LoginUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.authenticate(
          email: params._email, password: params._password);
      controller.close();
    } catch (e) {
      _logger.shout('Could not login the user.', e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// The parameters required for the [LoginUseCase]
class LoginUseCaseParams {
  String _email;
  String _password;

  LoginUseCaseParams(this._email, this._password);
}
