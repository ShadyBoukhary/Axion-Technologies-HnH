import 'dart:convert';

/// Represents the yearly HHH general event. Contains a list of [_events] and a list of [_sponsors].
/// The [_id] of the [HHH] is the year. Eg. `_id = 2019`.
class HHH {
  String _id; // year
  String _description;
  String _mailingAddress;
  String _timestamp;
  List<String> _sponsors;
  List<String> _events;

  String get id => _id;
  String get description => _description;
  String get mailingAddress => _mailingAddress;
  String get timestamp => _timestamp;
  List<String> get sponsors => _sponsors;
  List<String> get events => _events;

  HHH(this._id, this._description, this._mailingAddress, this._timestamp, this._sponsors, this._events);

  /// From a [map]
  HHH.fromJson(Map<String, dynamic> map) {
    _id = map['id'];
    _description = map['description'];
    _mailingAddress = map['mailingAddress'];
    _timestamp = map['timestamp'];
    _sponsors = map['sponsors'] as List<String>;
    _events = map['events'] as List<String>;
  }

  /// From an [hhh]
  HHH.fromHHH(HHH hhh) {
    _id = hhh._id;
    _description = hhh._description;
    _mailingAddress = hhh._mailingAddress;
    _timestamp = hhh._timestamp;
    _sponsors = List.from(hhh._sponsors);
    _events = List.from(hhh._events);
  }

  /// To a nested `Map`
  Map<String, dynamic> toJson() => 
  {
    'id': _id,
    'description': _description,
    'mailingAddress': _mailingAddress,
    'timestamp': _timestamp,
    'sponsors': _sponsors,
    'events': _events
  };

  /// To a `string` `map`
  Map<String, String> toJson2() => 
  {
    'id': _id,
    'description': _description,
    'mailingAddress': _mailingAddress,
    'timestamp': _timestamp,
    'sponsors': jsonEncode(_sponsors),
    'events': jsonEncode(_events)
  };

  /// Adds a list of [eventIds] to [_events]
  void addEvents(List<String> eventIds) {
    _events.addAll(eventIds);
  }

  /// Adds a list of [sponsorIds] to [_sponsors]
  void addSponsors(List<String> sponsorIds) {
    _sponsors.addAll(sponsorIds);
  }

}