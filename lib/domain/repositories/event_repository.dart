// Shady Boukhary

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/event_registration.dart';

/// Allows a `User` to register for an [Event] and retrieve [Event]s
abstract class EventRepository {

  /// Retrieves all [Event]s. Accepts filerting [params].
  Future<List<Event>> getAllEvents({Map<String, String> params});

  /// Retrieves all [Event]s in which the `User` is registered using his [uid].
  Future<List<Event>> getUserEvents({@required String uid});

  /// Registers a `User` in an [Event] using [eventRegistration] object.
  Future<void> registerForEvent({@required EventRegistration eventRegistration});

  /// Unregisters a `User` from an [Event] using [eventRegistration] object.
  Future<void> unRegisterFromEvent({@required EventRegistration eventRegistration});
}