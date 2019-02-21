import 'package:hnh/domain/usecases/observer.dart';

class SplashPresenter {
  Function splashOnComplete;
  Function splashOnError;

  SplashPresenter();
}

class _SplashObserver implements Observer<void> {
  SplashPresenter _splashPresenter;
  _SplashObserver(this._splashPresenter);

  void onNext(ignore) {}

  void onComplete() {}

  void onError(e) {}
}
