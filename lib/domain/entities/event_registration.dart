// Shady Boukhary

import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/utils/utils.dart';

/// Represents an association between a [User] and an [Event].
/// The [User] is registered in the [Event].
class EventRegistration {
  /// The [User]'s unique ID that registered.
  final String uid;

  /// The [Event] unique ID in which the [User] registered.
  final String eventId;

  /// The Unix timestamp of the registration.
  final String timestamp;

  EventRegistration(this.uid, this.eventId) : timestamp = Utils.newTimestamp;

  EventRegistration.fromEventRegistration(EventRegistration eventRegistration)
      : uid = eventRegistration.uid,
        eventId = eventRegistration.eventId,
        timestamp = eventRegistration.timestamp;

  EventRegistration.fromJson(Map<String, dynamic> map)
      : uid = map['uid'],
        eventId = map['eventId'],
        timestamp = map['timestamp'];

  // Serializer
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'eventId': eventId,
        'timestamp': timestamp,
      };

  Map<String, String> toJson2() => {
        'uid': uid,
        'eventId': eventId,
        'timestamp': timestamp,
      };
}
