import 'package:hnh/domain/usecases/observer.dart';
import 'package:flutter/foundation.dart';
import 'package:hnh/domain/usecases/forgot_password_usecase.dart';
class ForgotPwPresenter {

  Function forgotOnComplete;
  Function forgotOnError;
  ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPwPresenter(authRepo) {
    _forgotPasswordUseCase = ForgotPasswordUseCase(authRepo);
  }


  void dispose() {
    _forgotPasswordUseCase.dispose();
  }

  void forgotPassword({@required String email}) {
    _forgotPasswordUseCase.execute(_ForgotPwUserCaseObserver(this), ForgotPasswordUseCaseParams(email));
  }
}
  
  class _ForgotPwUserCaseObserver implements Observer<void> {
    ForgotPwPresenter _forgotPwPresenter;

    _ForgotPwUserCaseObserver(this._forgotPwPresenter);

    void onNext(_) {}

    void onComplete() {
      assert (_forgotPwPresenter.forgotOnComplete != null);
      _forgotPwPresenter.forgotOnComplete();
    }

    void onError(e) {
      assert (_forgotPwPresenter.forgotOnError != null);
      _forgotPwPresenter.forgotOnError(e);
      
    }
}