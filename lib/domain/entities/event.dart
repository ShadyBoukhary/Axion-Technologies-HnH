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
  int lastVisitedPoint;
  bool _isFeatured;
  double _totalDistance;
  double _distanceTravelled;
  Coordinates _lastKnownPosition;

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
  double get distanceTravelled => _distanceTravelled; 

  // Constructors

  // Default
  Event(this._name, this._description, this._location, this._id,
      [this._isFeatured, this._route, this._imageUrl, this._stops])
      : _totalDistance = -1, lastVisitedPoint = -1, _distanceTravelled = 0;

  /// From an [Event]
  Event.fromEvent(Event event) : _totalDistance = -1, lastVisitedPoint = -1, _distanceTravelled = 0 {
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
  Event.fromJson(Map<String, dynamic> map) : _totalDistance = -1, lastVisitedPoint = -1, _distanceTravelled = 0 {
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

  /// Calculates the total distance of the [_route].
  /// Complexity: `O(n)` if called for the first time and `O(1)` if called again.
  /// Lazily calcualtes the total route for the race.
  double calculateRouteDistance({DistanceUnit unit = DistanceUnit.miles}) {
    if (_totalDistance != -1) {
      return _totalDistance;
    }

    _totalDistance = 0;
    for (int i = 0; i < _route.length - 2; i++) {
      _totalDistance += _route[i].distanceTo(_route[i + 1], unit);
    }
    return _totalDistance;
  }

  /// Finds the remaining distance to the finish line given the [currentPosition].
  /// Calculated in a give [unit] of distance.
  /// Worst-case complexity of `O(n^2)`
  /// Average complexity: `O(n)`
  double _distanceRemaining(Coordinates currentPosition, {DistanceUnit unit = DistanceUnit.miles}) {
    if (lastVisitedPoint == -1) {
      return calculateRouteDistance();
    }

    double remainingDistance = 0;
    // Find the remaining distance starting from the current calculated index
    for (int i = lastVisitedPoint; i < _route.length - 2; i++) {
      remainingDistance += _route[i].distanceTo(_route[i + 1], unit);
    }

    return remainingDistance;
  }

    /// Finds the closes [Coordinates] index in the [_route] to a given [currentPosition]
  /// in a specific [unit] of distance.
  /// `O(n)` complexity
  int _findClosest(Coordinates currentPosition, DistanceUnit unit) {
    int closestIdx = 0;
    double closestDistance = currentPosition.distanceTo(_route[closestIdx], unit);

    /// `O(n - 1)` loop to find the shortest distance
    for (int i = 1; i < _route.length - 1; i++) {
      double distance = currentPosition.distanceTo(_route[i], unit);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestIdx = i;
      }
    }
    return closestIdx;
  }

  /// Finds the remaining distance to HG line given the [currentPosition].
  /// Calculated in a give [unit] of distance.
  /// Worst-case complexity of `O(n^2)`
  double distanceToHellsGate(Coordinates currentPosition, {DistanceUnit unit = DistanceUnit.miles}) {
    int start = lastVisitedPoint;
    if (lastVisitedPoint == -1) {
      start = 0;
    }

    double remainingDistance = 0;
    // find the closest point in the race to HG 
    // this approach is used since HG is not a part of every route (only the 100 mile route)
    int hgIndex = _findClosest(hellsGate, unit);
    // distance already covered from last visited point to current user position
    // TODO: Figure out how to deal with distance between last visited and user's current position
    //double distanceCovered = currentPosition.distanceTo(_route[start], unit);
    // approximation of the distance between the closest point to HG in the route and
    // the real position of HG. This is necessary for the routes that actually do not
    // include HG along their routes
    double distanceFromClosestToHG = _route[hgIndex].distanceTo(hellsGate, unit);
    // Find the remaining distance starting from the current calculated index
    for (int i = start; i < hgIndex - 1; i++) {
      remainingDistance += _route[i].distanceTo(_route[i + 1], unit);
    }

    // remaining distance + approx distance to HG - the distance already covered after passed the last visited point
    return remainingDistance + distanceFromClosestToHG;
  }

  /// Advance the user's position in the race. 
  /// 
  /// The distance from the user's [currentPosition] to the next [Coordinates] to be visited in 
  /// the [_route] is calculated using the [unit] of choice.
  /// Then, if the [distanceToNext] is less than `16 meters`, the [lastVisitedPoint] is incremented,
  /// marking it as visited. The remaining distance to the last point in the race is calculated
  /// using [_distanceRemaining] in addition to the [distanceToNext].
  /// Worst-case complexity: `O(n^2)`
  /// Average complexity: `O(n)`
  double advancePosition(Coordinates currentPosition, {DistanceUnit unit = DistanceUnit.miles}) {
    if (_lastKnownPosition == null) {
      _lastKnownPosition = currentPosition;
    }
    _distanceTravelled += currentPosition.distanceTo(_lastKnownPosition, unit);

    // if already reached finish line
    if (lastVisitedPoint == _route.length - 1) {
      return 0;
    }

    double distanceToNext = currentPosition.distanceTo(_route[lastVisitedPoint + 1], unit);
    // if within 16 meters, visit point
    if (distanceToNext <= 0.01) {
      lastVisitedPoint++;
    }
    // the actual remaining distance is the distance to the point to be visited and the remaining distance
    // for the rest of the route
    return _distanceRemaining(currentPosition, unit: unit) + distanceToNext;
  }
}
