import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/entities/event.dart';

/// Represents an association between a [User] and an [Event].
/// The [User] is registered in the [Event].
class EventRegistration {

  // Members
  String _uid;
  String _eventId;
  String _timestamp;
  // Getters
  String get uid => _uid;
  String get eventId => _eventId;
  String get timestamp => _timestamp;
  // Constructors

  EventRegistration(this._uid, this._eventId) {
    _timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).toString();
  }

  EventRegistration.fromEventRegistration(EventRegistration eventRegistration) {
    _uid = eventRegistration.uid;
    _eventId = eventRegistration.eventId;
    _timestamp = eventRegistration._timestamp;
  }

  EventRegistration.fromJson(Map<String, dynamic> map) {
    _uid = map['uid'];
    _eventId = map['eventId'];
    _timestamp = map['timestamp'];
  }

  // Serializer
  Map<String, dynamic> toJson() =>
    {
      'uid': uid,
      'eventId': eventId,
      'timestamp': timestamp,
    };

  Map<String, String> toJson2() => 
    {
      'uid': _uid,
      'eventId': eventId,
      'timestamp': timestamp,
    };
}