import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/repositories/event_repository.dart';

class GetAllEventsUseCase extends UseCase<List<Event>, void> {
  EventRepository _eventRepository;
  GetAllEventsUseCase(this._eventRepository);

  @override
  Future<Stream<List<Event>>> buildUseCaseStream(void ignore) async {
    final StreamController<List<Event>> controller = StreamController();
    try {
      List<Event> events = await _eventRepository.getAllEvents();
      controller.add(events);
      logger.finest('GetAllEventsUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetAllEventsUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
