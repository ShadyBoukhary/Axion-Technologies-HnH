// Shady Boukhary

import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'dart:convert';

/// An HHH event. The event could either be a regular event of a race, in which case
/// it has more functionality. 
class Event {

  /// The official name of the event.
  String _name;

  /// The description of the event. This can be multi-line and include information
  /// such as start and end dates - as well as price for entry.
  String _description;

  /// The location at which the event will be held. This also includes the start time.
  Location _location; 

  /// The unique ID of the event.
  String _id;

  /// The route of the event. Empty if not a race.
  List<Coordinates> _route;

  /// The rest stops of the event. Empty if not a race.
  List<Coordinates> _stops;

  /// The link to the image of the event.
  String _imageUrl;

  /// Whether the event should be a part of the `featured` events.
  bool _isFeatured;

  // Getters
  String get name => _name;
  String get description => _description;
  Location get location => _location;
  String get id => _id;
  List<Coordinates> get route => _route;
  List<Coordinates> get stops => _stops;
  Coordinates get hellsGate => _stops != null ? _stops[0] : Coordinates('', '');
  Coordinates get finishLine =>
      _stops != null ? _stops[1] : Coordinates('', '');
  Coordinates get medicalStop =>
      _stops != null ? _stops[2] : Coordinates('', '');

  DateTime get eventTime => DateTime.fromMillisecondsSinceEpoch(
      int.parse(_location.timestamp) * 1000);
  String get imageUrl => _imageUrl;
  bool get isFeatured => _isFeatured;
  bool get isRace => _route.length > 0;

  // Constructors

  // Default
  Event(this._name, this._description, this._location, this._id,
      [this._isFeatured, this._route, this._imageUrl, this._stops]);

  /// From an [Event]
  Event.fromEvent(Event event) {
    _name = event._name;
    _description = event._description;
    _location = Location.fromLocation(event._location);
    _id = event._id;
    _route = List<Coordinates>()..addAll(event._route);
    _imageUrl = event._imageUrl;
    _isFeatured = event._isFeatured;
    _stops = event._stops;
  }

  /// From a [map]
  Event.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _description = map['description'];
    _location = Location.fromJson(map['location']);
    _id = map['id'];
    var coordsIt = (map['route'].cast<Map<String, dynamic>>())
        .toList()
        .map((map) => Coordinates.fromJson(map));
    _route = List<Coordinates>.from(coordsIt);
    _imageUrl = map['imageUrl'];
    _isFeatured = map['isFeatured'];
    var stopsList = (map['stops'].cast<Map<String, dynamic>>())
        .toList()
        .map((map) => Coordinates.fromJson(map));
    _stops = List<Coordinates>.from(stopsList);
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'description': _description,
        'location': _location.toJson(),
        'id': _id,
        'route': jsonDecode(jsonEncode(_route)),
        'imageUrl': _imageUrl,
        'isFeatured': _isFeatured,
        'stops': jsonDecode(jsonEncode(_stops)),
      };

  Map<String, String> toJson2() => {
        'name': _name,
        'description': _description,
        'location': jsonEncode(location),
        'id': _id,
        'route': jsonEncode(_route),
        'imageUrl': _imageUrl,
        'isFeatured': jsonEncode(_isFeatured),
        'stops': jsonEncode(_stops),
      };

  /// Append [coordinates] to the [_route]
  void appendRoute(List<Coordinates> coordinates) {
    _route.addAll(coordinates);
  }
}
