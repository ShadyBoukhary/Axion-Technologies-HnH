// Shady Boukhary

import 'package:hnh/domain/entities/coordinates.dart';

/// Represents a set of GPS coordinates from [Coordinates] along with a timestamp
class Location extends Coordinates {
  
  // Members
  String _timestamp;

  // Properties
  String get timestamp => _timestamp;

  // Constructors

  @override
  Location(String lat, String lon, this._timestamp): super(lat, lon);

  @override
  Location.fromLocation(Location location): super(location.lat, location.lon)  {
      _timestamp = location.timestamp;
  }

  @override
  Location.fromJson(Map<String, dynamic> map): super.fromJson({'lat': map['lat'], 'lon': map['lon']}) {
    _timestamp = map['timestamp'];
  }

  @override
  String toString() => '{ lat: $lat, lon: $lon, timestamp: $timestamp }';

  @override
  Map<String, dynamic> toJson() =>
    {
      'lat': lat,
      'lon': lon,
      'timestamp': _timestamp
    };

  Map<String, String> toJson2() => 
  {
    'lat': lat,
    'lon': lon,
    'timestamp': _timestamp
  };
}