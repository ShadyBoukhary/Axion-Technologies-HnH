import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'package:hnh/domain/entities/user.dart';

abstract class EventRepository {
  Future<List<Event>> getAllEvents();
  Future<List<Event>> getUserEvents({@required String uid});
  Future<void> registerForEvent({@required EventRegistration eventRegistration});
  Future<List<EventRegistration>> getEventRegistrationsByUser({@required String uid});
}