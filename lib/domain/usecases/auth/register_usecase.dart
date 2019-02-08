import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// A `UseCase` for registering a new `User` in the application
class RegisterUseCase extends CompletableUseCase<RegisterUseCaseParams> {

  // Members
  AuthenticationRepository _authenticationRepository;

  // Constructors
  RegisterUseCase(this._authenticationRepository);

  
  @override
  Future<Observable<User>> buildUseCaseObservable(RegisterUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.register(username: params._username, password: params._password);
      controller.close();
    } catch (e) {
      print(e);
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

/// The parameters required for the [RegisterUseCase]
class RegisterUseCaseParams {
  String _username;
  String _password;

  RegisterUseCaseParams(this._username, this._password);
}
