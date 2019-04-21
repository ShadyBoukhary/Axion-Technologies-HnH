// Shady Boukhary
import 'dart:math';

/// Represents a generic set of GPS coordinates
class Coordinates {
  /// Latitude as a `String`
  final String lat;

  /// Longitude as a `String`
  final String lon;

  /// Latitude as a `double`
  double get numLat => double.parse(lat);

  /// Longitude as a `double`
  double get numLon => double.parse(lon);

  Coordinates(this.lat, this.lon);

  Coordinates.from(Coordinates location)
      : lat = location.lat,
        lon = location.lon;

  Coordinates.fromJson(Map<String, dynamic> map)
      : lat = map['lat'],
        lon = map['lon'];

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lon': lon,
      };

  /// Convert [this] to a Json `Map<String, String>`. All complex structures
  /// are also converted to `String`.
  Map<String, String> toJson2() => {
        'lat': lat,
        'lon': lon,
      };

  /// Calculate the distance between this [Coordinates] and [other] in a specific [unit]
  /// Source adapted from: `https://www.geodatasource.com/developers/javascript`
  double distanceTo(Coordinates other, DistanceUnit unit) {
    if ((lat == other.lat) && (lon == other.lon)) {
      return 0;
    } else {
      var radlat1 = pi * numLat / 180;
      var radlat2 = pi * other.numLat / 180;
      var theta = numLon - other.numLon;
      var radtheta = pi * theta / 180;
      var dist = sin(radlat1) * sin(radlat2) +
          cos(radlat1) * cos(radlat2) * cos(radtheta);
      if (dist > 1) {
        dist = 1;
      }
      dist = acos(dist);
      dist = dist * 180 / pi;
      dist = dist * 60 * 1.1515;
      if (unit == DistanceUnit.kilometers) {
        dist = dist * 1.609344;
      }
      if (unit == DistanceUnit.nMiles) {
        dist = dist * 0.8684;
      }
      return dist;
    }
  }

  /// Returns a `String` in the form of `lat,lon`
  @override
  String toString() => '$lat,$lon';

  /// Returns a `String` in the form of `lat2Clon`
  String toString2() => '${lat}2C$lon';

  @override
  operator ==(dynamic other) =>
      other is Coordinates && lat == other.lat && lon == other.lon;

  @override
  int get hashCode => lat.hashCode ^ lon.hashCode;
}

/// The unit in which distance is measured.
enum DistanceUnit { miles, nMiles, kilometers }
