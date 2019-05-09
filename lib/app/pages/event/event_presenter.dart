import 'package:hnh/domain/entities/event.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/usecases/register_for_event_usecase.dart';
import 'package:hnh/domain/usecases/get_user_events_usecase.dart';
import 'package:hnh/domain/usecases/unregister_event_usecase.dart';
import 'package:meta/meta.dart';

class EventPresenter extends Presenter {
  Function registerOnComplete;
  Function registerOnError;

  Function unRegisterOnComplete;
  Function unRegisterOnError;

  Function isRegisteredOnNext;
  Function isRegisteredOnComplete;
  Function isRegisteredOnError;

  RegisterEventUseCase _registerEventUseCase;
  GetUserEventsUseCase _getUserEventsUseCase;
  UnRegisterEventUseCase _unRegisterEventUseCase;

  String _eventId;

  EventPresenter(eventRepo) {
    _registerEventUseCase = RegisterEventUseCase(eventRepo);
    _getUserEventsUseCase = GetUserEventsUseCase(eventRepo);
    _unRegisterEventUseCase = UnRegisterEventUseCase(eventRepo);
  }

  void dispose() {
    _registerEventUseCase.dispose();
    _getUserEventsUseCase.dispose();
    _unRegisterEventUseCase.dispose();
  }

  void registerForEvent({@required String uid, @required String eventId}) {
    _registerEventUseCase.execute(_RegisterEventObserver(this), RegisterEventUseCaseParams(uid, eventId));
  }

  void unRegisterFromEvent({@required String uid, @required String eventId}) {
    _unRegisterEventUseCase.execute(_UnRegisterEventObserver(this), UnRegisterEventUseCaseParams(uid, eventId));
  }

  void isRegistered({@required String eventId, @required String uid}) {
    _eventId = eventId;
    _getUserEventsUseCase.execute(_GetUserEventsObserver(this), GetUserEventsUseCaseParams(uid));
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

class _UnRegisterEventObserver implements Observer<void> {
  EventPresenter _homePresenter;
  _UnRegisterEventObserver(this._homePresenter);

  void onNext(_) {}

  void onComplete() {
    assert(_homePresenter.unRegisterOnComplete != null);
    _homePresenter.unRegisterOnComplete();
  }

  void onError(e) {
    assert(_homePresenter.unRegisterOnError != null);
    _homePresenter.unRegisterOnError(e);
  }
}

class _GetUserEventsObserver implements Observer<List<Event>> {
  EventPresenter _eventPresenter;
  _GetUserEventsObserver(this._eventPresenter);
  

  void onNext(events) {
    assert(_eventPresenter.isRegisteredOnNext != null);
    List<Event> matchingEvents = events.where((event) => event.id ==_eventPresenter._eventId).toList();
    _eventPresenter.isRegisteredOnNext(matchingEvents.length == 1 ? true : false);
  }

  void onComplete() {
    assert(_eventPresenter.isRegisteredOnComplete != null);
    _eventPresenter.isRegisteredOnComplete();
  }

  void onError(e) {
    assert(_eventPresenter.isRegisteredOnError != null);
    _eventPresenter.isRegisteredOnError(e);
  }
}
