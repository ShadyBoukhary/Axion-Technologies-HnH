// Shady Boukhary

import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'dart:convert';

class Event {
  // Members
  String _name;
  String _description;
  Location _location; // also contains the start time
  String _id;
  List<Coordinates> _route;
  List<Coordinates> _stops;
  String _imageUrl;
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
