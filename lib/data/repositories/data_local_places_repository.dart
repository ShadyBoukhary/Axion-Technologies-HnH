import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:hnh/domain/repositories/local_places_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/utils/http_helper.dart';

import 'dart:async';

class DataLocalPlacesRepository implements LocalPlacesRepository {
  // singleton
  static final DataLocalPlacesRepository _instance =
      DataLocalPlacesRepository._internal();
  Logger _logger;
  List<LocalPlace> _localPlaces;

  DataLocalPlacesRepository._internal() {
    _logger = Logger('DataLocalPlacesRepository');
  }
  // get singleton instance
  factory DataLocalPlacesRepository() => _instance;

  @override
  Future<List<LocalPlace>> getLocalRestaurants({@required Coordinates latlon}) {
    return _getLocalPlaces(latlon: latlon, type: LocalPlaceType.restaurant);
  }

  Future<List<LocalPlace>> _getLocalPlaces({@required Coordinates latlon, LocalPlaceType type}) async {
    Map<String, dynamic> body;
    String localPlaceType = type == LocalPlaceType.restaurant ? 'restaurant' : 'hotel';
    Map<String, String> query = {
      'location': latlon.toString(),
      'radius'  : Constants.placesRadius,
      'type'    : localPlaceType,
      'key'     : Constants.placesApiKey
    };

    Uri uri = Uri.https(Constants.googleApi, Constants.googleLocalPlacesPath, query);

    try {
      body = await HttpHelper.invokeHttp(uri, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve Local Places.', error);
      rethrow;
    }

    _localPlaces = mapJsonResponseToLocalPlaceList(body, type);
    _logger.finest('Local Places retrieved successfully.');
    return _localPlaces;
  }

  /// Converts a Google Places API response to an array of [LocalPlace].
  List<LocalPlace> mapJsonResponseToLocalPlaceList(Map<String, dynamic> map, LocalPlaceType type) {
    List<dynamic> results = map['results'];
    if (results.isEmpty) {
      return List<LocalPlace>();
    }

    return results.map((place) {
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
    }).toList();
  }
}
