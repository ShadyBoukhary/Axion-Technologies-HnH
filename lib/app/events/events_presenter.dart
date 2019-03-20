import 'package:hnh/domain/usecases/observer.dart';

class EventsPresenter {
  Function mapOnComplete;
  Function mapOnError;

  EventsPresenter();
}

class _EventsPresenter implements Observer<void> {
  EventsPresenter _eventsPresenter;
  _EventsPresenter(this._eventsPresenter);

  void onNext(ignore) {}

  void onComplete() {}

  void onError(e) {}
}