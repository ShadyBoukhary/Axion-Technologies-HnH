import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';

/// Maps a google [place] to a [LocalPlace]
LocalPlace mapGooglePlaceToLocalPlace(dynamic place, LocalPlaceType type) {
  var latlon = place['geometry']['location'];
  Coordinates coordinates = Coordinates(latlon['lat'].toString(), latlon['lng'].toString());
  String name = place['name'];
  String icon = place['icon'];
  bool isOpen = place['opening_hours']['open_now'] as bool;
  double rating = place['rating'].toDouble();
  String address = place['vicinity'];
  String photo = place['photos'][0]['html_attributions'][0];
  photo = photo.split(RegExp('"'))[1];
  return LocalPlace(name, address, type, coordinates, rating, icon, photo, isOpen);
}

/// Maps a list of google [place]s to a list of [LocalPlace]s
List<LocalPlace> mapGooglePlacesToLocalPlaces(Map<String, dynamic> map, LocalPlaceType type) {
  List<dynamic> results = map['results'];
    if (results.isEmpty) {
      return List<LocalPlace>();
    }

    return results.map((place) => mapGooglePlaceToLocalPlace(place, type)).toList();
}
