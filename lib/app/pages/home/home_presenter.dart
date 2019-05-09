import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/usecases/get_hhh_usecase.dart';
import 'package:hnh/domain/usecases/get_current_user_usecase.dart';

class HomePresenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function getHHHOnNext;
  Function getHHHOnComplete;
  Function getHHHOnError;

  GetHHHUseCase _getHHHUseCase;
  GetCurrentUserUseCase _getCurrentUserUseCase;

  HomePresenter(hhhRepository, sponsorRepository, authenticationRepository) {
    _getHHHUseCase = GetHHHUseCase(hhhRepository, sponsorRepository);
    _getCurrentUserUseCase =GetCurrentUserUseCase(authenticationRepository);
  }

  void dispose() {
    //  _userUseCase.dispose();
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
  HomePresenter _homePresenter;

  _GetHHHUseCaseObserver(this._homePresenter);

  void onNext(response) {
    // any cleaning or preparation goes here before invoking callback
    assert(response is GetHHHUseCaseResponse);
    assert(_homePresenter.getHHHOnNext != null);
    _homePresenter.getHHHOnNext(response.hhh);
  }

  void onComplete() {
    assert(_homePresenter.getHHHOnComplete != null);
    _homePresenter.getHHHOnComplete();
  }

  void onError(e) {
    // any cleaning or preparation goes here
    assert(_homePresenter.getHHHOnError != null);
    _homePresenter.getHHHOnError(e);
    
  }
}

class _GetUserUseCaseObserver implements Observer<User> {
  HomePresenter _userPresenter;

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
