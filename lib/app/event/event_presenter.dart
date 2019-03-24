import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/usecases/register_for_event_usecase.dart';
import 'package:meta/meta.dart';

class EventPresenter {
  Function registerOnComplete;
  Function registerOnError;

  RegisterEventUseCase _registerEventUseCase;

  EventPresenter(eventRepo) {
    _registerEventUseCase = RegisterEventUseCase(eventRepo);
  }

  void dispose() {
    _registerEventUseCase.dispose();
  }

  void registerForEvent({@required String uid, @required String eventId}) {
    _registerEventUseCase.execute(_RegisterEventObserver(this));
  }
}

class _RegisterEventObserver implements Observer<void> {
  EventPresenter _homePresenter;
  _RegisterEventObserver(this._homePresenter);

  void onNext(_) {}

  void onComplete() {
    assert(_homePresenter.registerOnComplete != null);
    _homePresenter.registerOnComplete();
  }

  void onError(e) {
    assert(_homePresenter.registerOnError != null);
    _homePresenter.registerOnError(e);
  }
}
