import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/repositories/event_repository.dart';

/// A `UseCase` for registering a `User` into an [Event]
class RegisterEventUseCase
    extends CompletableUseCase<RegisterEventUseCaseParams> {
  // Members
  EventRepository _eventRepository;

  // Constructors
  RegisterEventUseCase(this._eventRepository) : super();

  @override
  Future<Stream<User>> buildUseCaseStream(
      RegisterEventUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    EventRegistration eventRegistration =
        EventRegistration(params._uid, params._eventId);
    try {
      await _eventRepository.registerForEvent(
          eventRegistration: eventRegistration);
      logger.finest('RegisterEventUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('RegisterEventUseCase unsuccessful.', e);
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// The parameters required for the [RegisterUseCase]
class RegisterEventUseCaseParams {
  String _uid;
  String _eventId;
  RegisterEventUseCaseParams(this._uid, this._eventId);
}
