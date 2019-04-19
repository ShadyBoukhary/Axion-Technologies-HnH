// Shady Boukhary
import 'dart:math';

/// Represents a generic set of GPS coordinates
class Coordinates {
  // Members
  String _lat;
  String _lon;

  // Properties
  String get lat => _lat;
  String get lon => _lon;

  double get numLat => double.parse(_lat);
  double get numLon => double.parse(_lon);

  // Constructors
  Coordinates(this._lat, this._lon);

  Coordinates.from(Coordinates location) {
    _lat = location._lat;
    _lon = location._lon;
  }

  Coordinates.fromJson(Map<String, dynamic> map) {
    _lat = map['lat'];
    _lon = map['lon'];
  }

  Map<String, dynamic> toJson() => {
        'lat': _lat,
        'lon': _lon,
      };

  Map<String, String> toJson2() => {
        'lat': _lat,
        'lon': _lon,
      };

  /// Calculate the distance between this [Coordinates] and [other] in a specific [unit]
  /// Source adapted from: `https://www.geodatasource.com/developers/javascript`
  double distanceTo(Coordinates other, DistanceUnit unit) {
    if ((_lat == other._lat) && (_lon == other._lon)) {
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

  @override
  String toString() => '$_lat,$_lon';

  String toString2() => '${_lat}2C$_lon';

  @override
  operator ==(dynamic other) =>
      other is Coordinates && _lat == other._lat && _lon == other._lon;

  @override
  int get hashCode => _lat.hashCode ^ _lon.hashCode;
}

enum DistanceUnit { miles, nMiles, kilometers }
