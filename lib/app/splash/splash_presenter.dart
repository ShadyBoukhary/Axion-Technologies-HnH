import 'package:hnh/domain/usecases/observer.dart';

class SplashPresenter {
  Function splashOnComplete;
  Function splashOnError;

  SplashPresenter();
}

class _StupidFuckingShitObserver implements Observer<void> {
  SplashPresenter _splashPresenter;
  _StupidFuckingShitObserver(this._splashPresenter);

  void onNext(ignore) {}

  void onComplete() {}

  void onError(e) {}
}
