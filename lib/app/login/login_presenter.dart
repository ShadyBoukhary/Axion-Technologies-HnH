import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/auth/login_usecase.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'package:flutter/foundation.dart';
class LoginPresenter {

  AuthenticationRepository _authenticationRepository;
  LoginUseCase _loginUseCase;

  // Controller Callback functions
  Function loginOnComplete;
  Function loginOnError;

  LoginPresenter(this._authenticationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    _loginUseCase = LoginUseCase(_authenticationRepository);
  }

  /// Disposed of the [LoginUseCase] and unsubscribes
  void _dispose() {
    _loginUseCase.dispose();
  }

  /// Login using the [email] and [password] provided
  void login({@required String email, @required String password}) {
    _loginUseCase.execute(_LoginUserCaseObserver(this), LoginUseCaseParams(email, password));
  }
}

/// The [Observer] used to observe the `Observable` of the [LoginUseCase]
class _LoginUserCaseObserver implements Observer<void> {

  // The above presenter
  LoginPresenter _loginPresenter;

  _LoginUserCaseObserver(this._loginPresenter);

  /// implement if the `Observable` emits a value
  void onNext(ignore) {}

  /// Login is successfull, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter._dispose();
    _loginPresenter.loginOnComplete();

  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    _loginPresenter._dispose();
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError(e);
    }
  }
}
