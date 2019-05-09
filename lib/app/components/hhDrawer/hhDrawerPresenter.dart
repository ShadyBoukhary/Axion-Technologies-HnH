import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/usecases/auth/logout_usecase.dart';
import 'package:hnh/domain/usecases/get_current_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
class HHDrawerPresenter extends Presenter {
  Function logoutOnComplete;
  
  Function getUserOnNext;
  Function getUserOnError;

  LogoutUseCase _logoutUseCase;
  GetCurrentUserUseCase _getCurrentUserUseCase;
  HHDrawerPresenter(authenticationRepository) {
    _logoutUseCase = LogoutUseCase(authenticationRepository);
    _getCurrentUserUseCase = GetCurrentUserUseCase(authenticationRepository);
  }

  /// Disposes of the [_logoutUseCase] and unsubscribes
  void dispose() => _logoutUseCase.dispose();
  void logout() => _logoutUseCase.execute(_LogoutUserCaseObserver(this));
  void getUser() => _getCurrentUserUseCase.execute(_GetUserUseCaseObserver(this));
}

/// The [Observer] used to observe the `Observable` of the [LogoutUseCase]
class _LogoutUserCaseObserver implements Observer<void> {
  HHDrawerPresenter _drawerPresenter;
  _LogoutUserCaseObserver(this._drawerPresenter);

  void onNext(_){}
  void onComplete()  { 
    _drawerPresenter.logoutOnComplete();
    _drawerPresenter.dispose();
  }
  void onError(_) {}
}

/// Observer that listens to [_getUserUseCase]
class _GetUserUseCaseObserver implements Observer<User> {
  HHDrawerPresenter _drawerPresenter;

  _GetUserUseCaseObserver(this._drawerPresenter);

  void onNext(user) {
    // any cleaning or preparation goes here before invoking callback
    assert(user is User);
    _drawerPresenter.getUserOnNext(user);
  }

  void onComplete() {}

  void onError(e) {
    // any cleaning or preparation goes here
    assert(_drawerPresenter.getUserOnError != null);
    _drawerPresenter.getUserOnError(e);
    
  }
}
