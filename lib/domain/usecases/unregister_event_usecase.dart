import 'package:hnh/domain/repositories/event_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'dart:async';

/// A `UseCase` for unregistering a `User` from an [Event]
class UnRegisterEventUseCase extends CompletableUseCase<UnRegisterEventUseCaseParams> {

  // Members
  EventRepository _eventRepository;

  // Constructors
  UnRegisterEventUseCase(this._eventRepository): super();

  @override
  Future<Observable<User>> buildUseCaseObservable(UnRegisterEventUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    EventRegistration eventRegistration = EventRegistration(params._uid, params._eventId);
    try {
      await _eventRepository.unRegisterFromEvent(eventRegistration: eventRegistration);
      logger.finest('UnRegisterEventUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('UnRegisterEventUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

/// The parameters required for the [RegisterUseCase]
class UnRegisterEventUseCaseParams {
  String _uid;
  String _eventId;
  UnRegisterEventUseCaseParams(this._uid, this._eventId);
}
