import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';

/// A `UseCase` for requesting a password reset.
class ForgotPasswordUseCase
    extends CompletableUseCase<ForgotPasswordUseCaseParams> {
  AuthenticationRepository _authenticationRepository;
  ForgotPasswordUseCase(this._authenticationRepository) : super();

  @override
  Future<Stream<User>> buildUseCaseStream(
      ForgotPasswordUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.forgotPassword(params.email);
      logger.shout('ForgortPasswordUseCase successful.');
      controller.close();
    } catch (e) {
      logger.shout('ForgortPasswordUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// The parameters required for the [ForgotPasswordUseCase]
class ForgotPasswordUseCaseParams {
  final String email;
  ForgotPasswordUseCaseParams(this.email);
}
