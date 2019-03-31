import 'package:hnh/domain/usecases/auth/logout_usecase.dart';
import 'package:hnh/domain/usecases/observer.dart';
class HHDrawerPresenter {
  Function logoutOnComplete;
  LogoutUseCase _logoutUseCase;

  HHDrawerPresenter(authenticationRepository) {
    _logoutUseCase = LogoutUseCase(authenticationRepository);
  }

  /// Disposes of the [_logoutUseCase] and unsubscribes
  void dispose() => _logoutUseCase.dispose();

  /// Login using the [email] and [password] provided
  void logout() => _logoutUseCase.execute(_LogoutUserCaseObserver(this));
}

/// The [Observer] used to observe the `Observable` of the [LogoutUseCase]
class _LogoutUserCaseObserver implements Observer<void> {
  HHDrawerPresenter _logoutPresenter;
  _LogoutUserCaseObserver(this._logoutPresenter);

  void onNext(_){}
  void onComplete()  { 
    _logoutPresenter.logoutOnComplete();
    _logoutPresenter.dispose();
  }
  void onError(_) {}
}
