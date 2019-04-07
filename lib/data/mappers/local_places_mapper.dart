import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';

/// Maps a google [place] to a [LocalPlace]
LocalPlace mapGooglePlaceToLocalPlace(dynamic place, LocalPlaceType type) {
  var latlon = place['geometry']['location'];
  Coordinates coordinates = Coordinates(latlon['lat'].toString(), latlon['lng'].toString());
  String name = place['name'];
  String icon = place['icon'];

  bool isOpen = true; // default
  // check if opening hours data is available
  if (place['opening_hours'] != null &&
      place['opening_hours']['open_now'] != null) {
    isOpen = place['opening_hours']['open_now'] as bool;
  }
  double rating = place['rating'].toDouble();
  String address = place['vicinity'];
  String photo = '404';
  String photoReference = '404';

  // get the image url
  String placeId = place['place_id'];
  Map<String, String> query = {'q': 'place_id:$placeId'};
  Uri uri = Uri.https(Constants.google, Constants.googlePlacePath, query);
  String navigationLink = uri.toString();
  
  // check if photo data is available
  if (place['photos'] != null &&
      place['photos'][0] != null &&
      place['photos'][0]['html_attributions'] != null) {
    photoReference = place['photos'][0]['photo_reference'].toString();


    Map<String, String> query = {'photoreference': photoReference, 'key': Constants.placesApiKey, 'maxwidth': '400'};
    Uri uri = Uri.https(Constants.googleApi, Constants.googlePlacesPhotoPath, query);
    // url to the photo
    photo = uri.toString();
  }
  return LocalPlace(name, address, type, coordinates, rating, icon, photo, isOpen, photoReference, navigationLink);
}

/// Maps a list of google [place]s to a list of [LocalPlace]s
List<LocalPlace> mapGooglePlacesToLocalPlaces(
    Map<String, dynamic> map, LocalPlaceType type) {
  List<dynamic> results = map['results'];
  if (results.isEmpty) {
    return List<LocalPlace>();
  }

  return results
      .map((place) => mapGooglePlaceToLocalPlace(place, type))
      .toList();
}
