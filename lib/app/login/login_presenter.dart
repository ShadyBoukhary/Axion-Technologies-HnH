import 'package:hnh/domain/repositories/user_repository.dart';
import 'package:hnh/domain/usecases/user_usercase.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/entities/user.dart';

class LoginPresenter {
  UserRepository _userRepository;
  UserUseCase _userUseCase;
  Function loginOnNext;
  Function loginOnComplete;
  Function loginOnError;

  LoginPresenter(this._userRepository) {
    _userUseCase = UserUseCase(_userRepository);
  }

  void _dispose() {
    _userUseCase.dispose();
  }

  void getUser(String uid) {
    //_userUseCase.execute(_GetUserUseCaseObserver(this), UserUseCaseParams(uid));
  }
}

class _GetUserUseCaseObserver implements Observer<void> {

  LoginPresenter _loginPresenter;

  _GetUserUseCaseObserver(this._loginPresenter);

  void onNext(ignore) {
    // any cleaning or preparation goes here before invoking callback
    _loginPresenter.loginOnNext();
  }
  void onComplete() {
    // any cleaning or preparation goes here
    _loginPresenter._dispose();
    if (_loginPresenter.loginOnComplete != null) {
      _loginPresenter.loginOnComplete();
    }
  }
  void onError(e) {
    // any cleaning or preparation goes here
    _loginPresenter._dispose();
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError();
    }
  }
}
