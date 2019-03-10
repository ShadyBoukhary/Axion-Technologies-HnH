import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/entities/user.dart';

class UserPresenter {

  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;


  void _dispose() {
  //  _userUseCase.dispose();
  }

  void getUser(String uid) {
   // _userUseCase.execute(_GetUserUseCaseObserver(this), UserUseCaseParams(uid));
  }
}

class _GetUserUseCaseObserver implements Observer<User> {

  UserPresenter _userPresenter;

  _GetUserUseCaseObserver(this._userPresenter);

  void onNext(user) {
    // any cleaning or preparation goes here before invoking callback
    assert(user is User);
    _userPresenter.getUserOnNext(user);
  }
  void onComplete() {
    // any cleaning or preparation goes here
    _userPresenter._dispose();
    if (_userPresenter.getUserOnComplete != null) {
      _userPresenter.getUserOnComplete();
    }
  }
  void onError(e) {
    // any cleaning or preparation goes here
    _userPresenter._dispose();
    if (_userPresenter.getUserOnError != null) {
      _userPresenter.getUserOnError();
    }
  }
}
