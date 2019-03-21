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
  String _imageUrl;

  // Getters
  String get name => _name;
  String get description => _description;
  Location get location => _location;
  String get id => _id;
  List<Coordinates> get route => _route;
  DateTime get eventTime => DateTime.fromMillisecondsSinceEpoch(int.parse(_location.timestamp) * 1000);
  String get imageUrl => _imageUrl;

  // Constructors

  // Default
  Event(this._name, this._description, this._location, this._id, [this._route, this._imageUrl]);

  /// From an [Event]
  Event.fromEvent(Event event) {
    _name = event._name;
    _description = event._description;
    _location = Location.fromLocation(event._location);
    _id = event._id;
    _route = List<Coordinates>()..addAll(event._route);
    _imageUrl = event._imageUrl;
  }

  /// From a [map]
  Event.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _description = map['description'];
    _location = Location.fromJson(map['location'] );
    _id = map['id'];
    var coordsIt = (map['route'].cast<Map<String, dynamic>>()).toList().map((map) => Coordinates.fromJson(map));
    _route = List<Coordinates>.from(coordsIt);
    _imageUrl = map['imageUrl'];
  }

  Map<String, dynamic> toJson() => 
  {
    'name': _name,
    'description': _description,
    'location': _location.toJson(),
    'id': _id,
    'route': jsonDecode(jsonEncode(_route)),
    'imageUrl': _imageUrl
  };

  Map<String, String> toJson2() => 
  {
    'name': _name,
    'description': _description,
    'location': jsonEncode(location),
    'id': _id,
    'route': jsonEncode(_route),
    'imageUrl': _imageUrl
  };

  /// Append [coordinates] to the [_route]
  void appendRoute(List<Coordinates> coordinates) {
    _route.addAll(coordinates);
  }
}