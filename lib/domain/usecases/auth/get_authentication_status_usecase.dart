import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// Retrieves the current authentication status of the [User]
class GetAuthStatusUseCase extends UseCase<bool, void> {
  AuthenticationRepository _authenticationRepository;
  GetAuthStatusUseCase(this._authenticationRepository);

  @override
  Future<Observable<bool>> buildUseCaseObservable(void ignore) async {
    final StreamController<bool> controller = StreamController();
    try {

      bool isAuth = await _authenticationRepository.isAuthenticated();
      controller.add(isAuth);
      logger.finest('GetAuthStatusUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetAuthStatusUseCase unsuccessful.');
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}




