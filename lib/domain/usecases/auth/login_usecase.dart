import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// A `UseCase` for logging in a `User` into the application
class LoginUseCase extends CompletableUseCase<LoginUseCaseParams> {

  // Members
  AuthenticationRepository _authenticationRepository;

  // Constructors
  LoginUseCase(this._authenticationRepository);

  @override
  Future<Observable<User>> buildUseCaseObservable(LoginUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.authenticate(username: params._username, password: params._password);
      controller.close();
    } catch (e) {
      print(e);
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

/// The parameters required for the [LoginUseCase]
class LoginUseCaseParams {
  String _username;
  String _password;

  LoginUseCaseParams(this._username, this._password);
}
