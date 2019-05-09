import 'package:hnh/domain/repositories/event_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// Retrieves all [Event]'s in which a [User] is currently registered. Uses 
/// [_eventRepository] to retrieve the [Event]'s.
class GetUserEventsUseCase extends UseCase<List<Event>, GetUserEventsUseCaseParams> {
  EventRepository _eventRepository;
  GetUserEventsUseCase(this._eventRepository);

  @override
  Future<Observable<List<Event>>> buildUseCaseObservable(GetUserEventsUseCaseParams params) async {
    final StreamController<List<Event>> controller = StreamController();
    try {
      List<Event> events = await _eventRepository.getUserEvents(uid: params._uid);
      controller.add(events);
      logger.finest('GetUserEventsUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetUserEventsUseCase unsuccessful.');
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

/// Parameters needed by the [GetUserEventsUseCase]
class GetUserEventsUseCaseParams {
  String _uid;
  String get uid => _uid;

  GetUserEventsUseCaseParams(this._uid);
}


