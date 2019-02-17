import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'dart:convert';


class Event {

  // Members
  String _name;
  String _description;
  Location _location; // also contains the start time
  List<Coordinates> _route;

  // Getters
  String get name => _name;
  String get description => _description;
  Location get location => _location;
  List<Coordinates> get route => _route;

  // Constructors

  // Default
  Event(this._name, this._description, this._location, [this._route]);

  /// From an [Event]
  Event.fromEvent(Event event) {
    _name = event._name;
    _description = event._description;
    _location = Location.fromLocation(event._location);
    _route = List<Coordinates>()..addAll(event._route);
  }

  /// From a [map]
  Event.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _description = map['description'];
    _location = Location.fromJson(map['location'] );
    var coordsIt = (map['route'] as List<Map<String, dynamic>>).map((map) => Coordinates.fromJson(map));
    _route = List<Coordinates>.from(coordsIt);
  }

  Map<String, dynamic> toJson() => 
  {
    'name': _name,
    'description': _description,
    'location': _location.toJson(),
    'route': jsonDecode(jsonEncode(_route))
  };

  /// Append [coordinates] to the [_route]
  void appendRoute(List<Coordinates> coordinates) {
    _route.addAll(coordinates);
  }
}