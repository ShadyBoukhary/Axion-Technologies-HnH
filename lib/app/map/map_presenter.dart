import 'package:hnh/domain/usecases/observer.dart';

class MapPresenter {
  Function mapOnComplete;
  Function mapOnError;

  MapPresenter();
}

class _MapObserver implements Observer<void> {
  MapPresenter _mapPresenter;
  _MapObserver(this._mapPresenter);

  void onNext(ignore) {}

  void onComplete() {}

  void onError(e) {}
}
