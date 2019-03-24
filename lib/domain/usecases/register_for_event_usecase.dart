import 'package:hnh/domain/repositories/event_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'dart:async';

/// A `UseCase` for registering a `User` into an [Event]
class RegisterEventUseCase extends CompletableUseCase<RegisterEventUseCaseParams> {

  // Members
  EventRepository _eventRepository;

  // Constructors
  RegisterEventUseCase(this._eventRepository): super();

  @override
  Future<Observable<User>> buildUseCaseObservable(RegisterEventUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    EventRegistration eventRegistration = EventRegistration(params._uid, params._eventId);
    try {
      await _eventRepository.registerForEvent(eventRegistration: eventRegistration);
      logger.finest('RegisterEventUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('RegisterEventUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

/// The parameters required for the [RegisterUseCase]
class RegisterEventUseCaseParams {
  String _uid;
  String _eventId;
  RegisterEventUseCaseParams(this._uid, this._eventId);
}
