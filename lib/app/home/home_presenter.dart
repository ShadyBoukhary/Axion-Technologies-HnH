import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/usecases/get_hhh_usecase.dart';

class HomePresenter {
  Function getUserOnNext;
  Function getUserOnComplete;
  Function getUserOnError;

  Function getHHHOnNext;
  Function getHHHOnComplete;
  Function getHHHOnError;

  GetHHHUseCase _getHHHUseCase;

  HomePresenter(hhhRepository, sponsorRepository) {
    _getHHHUseCase = GetHHHUseCase(hhhRepository, sponsorRepository);
  }

  void _dispose() {
    //  _userUseCase.dispose();
    _getHHHUseCase.dispose();
  }

  void getUser(String uid) {
    // _userUseCase.execute(_GetUserUseCaseObserver(this), UserUseCaseParams(uid));
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
    GetHHHUseCaseResponse data = response as GetHHHUseCaseResponse;
    assert(_homePresenter.getHHHOnNext != null);
    _homePresenter.getHHHOnNext(data.hhh);
  }

  void onComplete() {
    assert(_homePresenter.getHHHOnComplete != null);
    _homePresenter.getHHHOnComplete();
    _homePresenter._dispose();
  }

  void onError(e) {
    // any cleaning or preparation goes here
    _homePresenter._dispose();
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
