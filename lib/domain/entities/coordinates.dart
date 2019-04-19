// Shady Boukhary

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

  @override
  String toString() => '$_lat,$_lon';

  String toString2() => '${_lat}2C$_lon';

  @override
  operator ==(dynamic other) =>
      other is Coordinates && _lat == other._lat && _lon == other._lon;

  @override
  int get hashCode => _lat.hashCode ^ _lon.hashCode;
}
