import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/usecases/get_hhh_usecase.dart';
import 'package:hnh/domain/usecases/get_current_user_usecase.dart';

class SponsorsPresenter extends Presenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function getHHHOnNext;
  Function getHHHOnComplete;
  Function getHHHOnError;

  GetHHHUseCase _getHHHUseCase;
  GetCurrentUserUseCase _getCurrentUserUseCase;

  SponsorsPresenter(hhhRepository, sponsorRepository, authenticationRepository) {
    _getHHHUseCase = GetHHHUseCase(hhhRepository, sponsorRepository);
    _getCurrentUserUseCase = GetCurrentUserUseCase(authenticationRepository);
  }

  void dispose() {
    _getHHHUseCase.dispose();
    _getCurrentUserUseCase.dispose();
  }

  void getUser() {
    _getCurrentUserUseCase.execute(_GetUserUseCaseObserver(this));
  }

  void getCurrentHHH() {
    _getHHHUseCase.execute(_GetHHHUseCaseObserver(this));
  }
}

class _GetHHHUseCaseObserver implements Observer<GetHHHUseCaseResponse> {
  SponsorsPresenter _sponsorsPresenter;

  _GetHHHUseCaseObserver(this._sponsorsPresenter);

  void onNext(response) {
    // any cleaning or preparation goes here before invoking callback
    assert(response is GetHHHUseCaseResponse);
    assert(_sponsorsPresenter.getHHHOnNext != null);
    _sponsorsPresenter.getHHHOnNext(response.hhh, response.sponsors);
  }

  void onComplete() {
    assert(_sponsorsPresenter.getHHHOnComplete != null);
    _sponsorsPresenter.getHHHOnComplete();
  }

  void onError(e) {
    // any cleaning or preparation goes here
    assert(_sponsorsPresenter.getHHHOnError != null);
    _sponsorsPresenter.getHHHOnError(e);
    
  }
}

class _GetUserUseCaseObserver implements Observer<User> {
  SponsorsPresenter _userPresenter;

  _GetUserUseCaseObserver(this._userPresenter);

  void onNext(user) {
    // any cleaning or preparation goes here before invoking callback
    assert(user is User);
    _userPresenter.getUserOnNext(user);
  }

  void onComplete() {
    // any cleaning or preparation goes here
    assert(_userPresenter.getUserOnComplete != null);
    _userPresenter.getUserOnComplete();
  }

  void onError(e) {
    // any cleaning or preparation goes here
    assert(_userPresenter.getUserOnError != null);
    _userPresenter.getUserOnError(e);
  }
}