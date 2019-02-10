import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/auth/register_usecase.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'package:flutter/foundation.dart';

class RegisterPresenter {

  AuthenticationRepository _authenticationRepository;
  RegisterUserCase _registerUserCase;

  Function registerOnComplete;
  Function registerOnError;

  RegisterPresenter(this._authenticationRepository) {
    _registerUserCase = RegisterUserCase(_authenticationRepository);
  }

  void _dispose() {
    _registerUserCase.dispose();
  }

  void register({@required String firstName, String lastName, String email, String password}) {
    _registerUserCase.execute(_RegisterUserCaseObserver(this),
    RegisterUserCaseParams(firstName, lastName, email, password));
  }
}
  
  class _RegisterUserCaseObserver implements Observer<void> {
    RegisterPresenter _registerPresenter;

    _RegisterUserCaseObserver(this._registerPresenter);

    void onNext(ignore) {}

    void onComplete() {
      _registerPresenter._dispose();
      _registerPresenter.registerOnComplete();
    }

    void onError(e) {
      _registerPresenter._dispose();
      if(_registerPresenter.registerOnError != null) {
        _registerPresenter.registerOnError(e);
      }
    }
}