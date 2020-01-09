import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';

/// Retrieves the currently authenticated [User]
class GetCurrentUserUseCase extends UseCase<User, void> {
  AuthenticationRepository _authenticationRepository;
  GetCurrentUserUseCase(this._authenticationRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(void ignore) async {
    final StreamController<User> controller = StreamController();
    try {
      User user = await _authenticationRepository.getCurrentUser();
      controller.add(user);
      logger.finest('GetCurrentUserUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetCurrentUserUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
