/// Represents a set of GPS coordinates along with a timestamp
class Location {
  
  // Members
  String _lat;
  String _lon;
  String _timestamp;

  // Properties
  String get lat => _lat;
  String get lon => _lon;
  String get timestamp => _timestamp;

  // Constructors
  Location(this._lat, this._lon, this._timestamp);

  Location.fromUser(Location location) {
      _lat = location._lat;
      _lon = location._lon;
      _timestamp = location.timestamp;
  }

  Location.fromMap(Map<String, dynamic> map) {
    _lat = map['lat'];
    _lon = map['lon'];
    _timestamp = map['timestamp'];
  }

  Map<String, dynamic> toMap() =>
    {
      'lat': _lat,
      'lon': _lon,
      'timestamp': _timestamp
    };
}