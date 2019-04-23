import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// A `UseCase` for requesting a password reset.
class ForgotPasswordUseCase extends CompletableUseCase<ForgotPasswordUseCaseParams> {

  AuthenticationRepository _authenticationRepository;
  ForgotPasswordUseCase(this._authenticationRepository):super();

  @override
  Future<Observable<User>> buildUseCaseObservable(ForgotPasswordUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.forgotPassword(params.email);
      logger.shout('ForgortPasswordUseCase successful.');
      controller.close();
    } catch (e) {
      logger.shout('ForgortPasswordUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

/// The parameters required for the [ForgotPasswordUseCase]
class ForgotPasswordUseCaseParams {
  final String email;
  ForgotPasswordUseCaseParams(this.email);
}
