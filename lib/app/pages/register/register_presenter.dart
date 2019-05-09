import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/domain/usecases/auth/register_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter/foundation.dart';

class RegisterPresenter {

  AuthenticationRepository _authenticationRepository;
  RegisterUserCase _registerUserCase;

  Function registerOnComplete;
  Function registerOnError;

  RegisterPresenter(this._authenticationRepository) {
    _registerUserCase = RegisterUserCase(_authenticationRepository);
  }

  void dispose() {
    _registerUserCase.dispose();
  }

  void register({@required String firstName, @required String lastName, @required String email, @required String password}) {
    _registerUserCase.execute(_RegisterUserCaseObserver(this),
    RegisterUserCaseParams(firstName, lastName, email, password));
  }
}
  
  class _RegisterUserCaseObserver implements Observer<void> {
    RegisterPresenter _registerPresenter;

    _RegisterUserCaseObserver(this._registerPresenter);

    void onNext(ignore) {}

    void onComplete() {
      _registerPresenter.registerOnComplete();
    }

    void onError(e) {
      if(_registerPresenter.registerOnError != null) {
        _registerPresenter.registerOnError(e);
      }
    }
}