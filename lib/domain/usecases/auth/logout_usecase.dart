import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:logging/logging.dart';

/// A `UseCase` for logging out a `User`
class LogoutUseCase extends CompletableUseCase<void> {
  // Members
  AuthenticationRepository _authenticationRepository;
  Logger _logger;

  // Constructors
  LogoutUseCase(this._authenticationRepository) {
    _logger = Logger('LogoutUseCase');
  }

  @override
  Future<Stream<User>> buildUseCaseStream(void ignore) async {
    final StreamController<User> controller = StreamController();
    try {
      await _authenticationRepository.logout();
      controller.close();
    } catch (e) {
      _logger.shout('Could not logout the user.', e);
      controller.addError(e);
    }
    return controller.stream;
  }
}
