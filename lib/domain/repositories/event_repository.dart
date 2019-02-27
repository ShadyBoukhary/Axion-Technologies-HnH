import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/event.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
  Future<List<Event>> getUserEvents({@required String uid});
}