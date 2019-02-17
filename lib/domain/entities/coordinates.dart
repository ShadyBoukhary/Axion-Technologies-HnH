/// Represents a generic set of GPS coordinates
class Coordinates {
  
  // Members
  String _lat;
  String _lon;

  // Properties
  String get lat => _lat;
  String get lon => _lon;

  // Constructors
  Coordinates(this._lat, this._lon);

  Coordinates.fromUser(Coordinates location) {
      _lat = location._lat;
      _lon = location._lon;
  }

  Coordinates.fromJson(Map<String, dynamic> map) {
    _lat = map['lat'];
    _lon = map['lon'];
  }

  Map<String, dynamic> toJson() =>
    {
      'lat': _lat,
      'lon': _lon,
    };
}