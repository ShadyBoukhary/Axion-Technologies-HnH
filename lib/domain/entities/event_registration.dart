import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/entities/event.dart';

/// Represents an association between a [User] and an [Event].
/// The [User] is registered in the [Event].
class EventRegistration {

  // Members
  String _uid;
  String _eventId;
  String _timestamp;
  String _id;
  // Getters
  String get uid => _uid;
  String get eventId => _eventId;
  String get timestamp => _timestamp;
  String get id => _id;
  // Constructors

  EventRegistration(this._uid, this._eventId, [this._id]) {
    _timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).toString();
  }

  EventRegistration.fromEventRegistration(EventRegistration eventRegistration) {
    _uid = eventRegistration.uid;
    _eventId = eventRegistration.eventId;
    _timestamp = eventRegistration._timestamp;
    _id = eventRegistration._id;
  }

  EventRegistration.fromJson(Map<String, dynamic> map) {
    _uid = map['uid'];
    _eventId = map['eventId'];
    _timestamp = map['timestamp'];
    _id = map['id'];
  }

  // Serializer
  Map<String, dynamic> toJson() =>
    {
      'uid': uid,
      'eventId': eventId,
      'timestamp': timestamp,
      'id': _id
    };

  Map<String, String> toJson2() => 
    _id != null ? 
    {
      'uid': _uid,
      'eventId': eventId,
      'timestamp': timestamp,
      '_id': _id
    } : 
    {
      'uid': _uid,
      'eventId': eventId,
      'timestamp': timestamp,
    };
}