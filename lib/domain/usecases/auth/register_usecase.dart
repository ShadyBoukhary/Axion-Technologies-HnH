import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';

/// A `UseCase` for registering a new `User` in the application
class RegisterUserCase extends CompletableUseCase<RegisterUserCaseParams> {
  // Members
  AuthenticationRepository _authenticationRepository;

  // Constructors
  RegisterUserCase(this._authenticationRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(RegisterUserCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.register(
          firstName: params._firstName,
          lastName: params._lastName,
          email: params._email,
          password: params._password);
      controller.close();
    } catch (e) {
      logger.severe('RegisterUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// The parameters required for the [RegisterUseCase]
class RegisterUserCaseParams {
  String _firstName;
  String _lastName;
  String _email;
  String _password;

  RegisterUserCaseParams(
      this._firstName, this._lastName, this._email, this._password);
}
