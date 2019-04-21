// Shady Boukhary

import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/utils/utils.dart';

/// Represents a set of GPS coordinates from [Coordinates] along with a timestamp
class Location extends Coordinates {
  
  /// The time at which the [Location] was retrieved. In meters per second.
  final String timestamp;

  /// The speed at which the device was moving at the time of the [Location] retrieval.
  final double speed;

  /// The speed converted to miles per hour.
  double get speedInMiles => speed * 2.237;

  // Constructors

  @override
  Location(String lat, String lon, this.timestamp, this.speed)
      : super(lat, lon);

  Location.withoutTime(String lat, String lon, this.speed)
      : timestamp = Utils.newTimestamp,
        super(lat, lon);

  @override
  Location.fromLocation(Location location)
      : timestamp = location.timestamp,
        speed = location.speed,
        super(location.lat, location.lon);

  @override
  Location.fromJson(Map<String, dynamic> map)
      : timestamp = map['timestamp'],
        speed = map['speed'],
        super.fromJson({'lat': map['lat'], 'lon': map['lon']});

  factory Location.wichitaFalls() =>
      Location('33.911614', '-98.496268', '0', 0);

  @override
  String toString() =>
      '{ lat: $lat, lon: $lon, timestamp: $timestamp, speed: $speed }';

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  @override
  Map<String, dynamic> toJson() =>
      {'lat': lat, 'lon': lon, 'timestamp': timestamp, 'speed': speed};

  /// Convert [this] to a Json `Map<String, String>`. All complex structures
  /// are also converted to `String`.
  Map<String, String> toJson2() => {
        'lat': lat,
        'lon': lon,
        'timestamp': timestamp,
        'speed': speed.toString()
      };

  Coordinates toCoordinates() => Coordinates(lat, lon);
}
