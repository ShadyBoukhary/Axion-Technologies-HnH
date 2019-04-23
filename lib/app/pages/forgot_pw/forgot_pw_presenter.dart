import 'package:hnh/domain/usecases/observer.dart';
import 'package:flutter/foundation.dart';

class ForgotPwPresenter {

  Function forgotOnComplete;
  Function forgotOnError;

  ForgotPwPresenter() {
  }

  void dispose() {

  }

  void forgot({@required String email}) {
    
  }
}
  
  class _ForgotPwUserCaseObserver implements Observer<void> {
    ForgotPwPresenter _forgotPwPresenter;

    _ForgotPwUserCaseObserver(this._forgotPwPresenter);

    void onNext(ignore) {}

    void onComplete() {
      _forgotPwPresenter.forgotOnComplete();
    }

    void onError(e) {
      if(_forgotPwPresenter.forgotOnError != null) {
        _forgotPwPresenter.forgotOnError(e);
      }
    }
}