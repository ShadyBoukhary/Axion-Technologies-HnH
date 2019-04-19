// Shady Boukhary

import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/utils/utils.dart';

/// Represents a set of GPS coordinates from [Coordinates] along with a timestamp
class Location extends Coordinates {
  // Members
  String _timestamp;
  double _speed;

  // Properties
  String get timestamp => _timestamp;
  double get speed => _speed;
  double get speedInMiles => _speed * 2.237;

  // Constructors

  @override
  Location(String lat, String lon, this._timestamp, this._speed)
      : super(lat, lon);

  Location.withoutTime(String lat, String lon, this._speed) : super(lat, lon) {
    _timestamp = Utils.newTimestamp;
  }

  @override
  Location.fromLocation(Location location) : super(location.lat, location.lon) {
    _timestamp = location.timestamp;
    _speed = location._speed;
  }

  @override
  Location.fromJson(Map<String, dynamic> map)
      : super.fromJson({'lat': map['lat'], 'lon': map['lon']}) {
    _timestamp = map['timestamp'];
    _speed = map['speed'];
  }

  @override
  String toString() =>
      '{ lat: $lat, lon: $lon, timestamp: $timestamp, speed: $_speed }';

  @override
  Map<String, dynamic> toJson() =>
      {'lat': lat, 'lon': lon, 'timestamp': _timestamp, 'speed': _speed};

  Map<String, String> toJson2() => {
        'lat': lat,
        'lon': lon,
        'timestamp': _timestamp,
        'speed': _speed.toString()
      };

  Coordinates toCoordinates() => Coordinates(lat, lon);
}
