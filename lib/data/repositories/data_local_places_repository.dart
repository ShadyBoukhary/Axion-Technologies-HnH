import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:hnh/domain/repositories/local_places_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/utils/http_helper.dart';
import 'package:hnh/data/mappers/local_places_mapper.dart';

import 'dart:async';

class DataLocalPlacesRepository implements LocalPlacesRepository {
  // singleton
  static final DataLocalPlacesRepository _instance = DataLocalPlacesRepository._internal();
  Logger _logger;
  List<LocalPlace> _restaurants;
  List<LocalPlace> _hotels;

  DataLocalPlacesRepository._internal() {
    _logger = Logger('DataLocalPlacesRepository');
  }
  // get singleton instance
  factory DataLocalPlacesRepository() => _instance;

  @override
  /// Retrieve [_hotels] by calling the Google API if they were not already stored in memory
  Future<List<LocalPlace>> getLocalHotels({@required Coordinates latlon}) async {
    return _hotels ?? await _getLocalPlaces(latlon: latlon, type: LocalPlaceType.hotel);
  }

  @override
  /// Retrieve [_restaurants] by calling the Google API if they were not already stored in memory
  Future<List<LocalPlace>> getLocalRestaurants({@required Coordinates latlon}) async {
    return _restaurants ?? await _getLocalPlaces(latlon: latlon, type: LocalPlaceType.restaurant);
  }

  /// Retrieve local [_restaurants] or [_hotels] depending on the [type] passed and the [latlon] passed.
  Future<List<LocalPlace>> _getLocalPlaces({@required Coordinates latlon, LocalPlaceType type}) async {
    Map<String, dynamic> body;
    String localPlaceType = type == LocalPlaceType.restaurant ? 'restaurant' : 'lodging';

    // specifiy google api query parameters
    Map<String, String> query = {
      'location': latlon.toString(),
      'radius': Constants.placesRadius,
      'type': localPlaceType,
      'key': Constants.placesApiKey
    };

    Uri uri = Uri.https(Constants.googleApi, Constants.googleLocalPlacesPath, query);

    try {
      body = await HttpHelper.invokeHttp(uri, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve Local Places.', error);
      rethrow;
    }
    if (type == LocalPlaceType.restaurant) {
      _restaurants = mapGooglePlacesToLocalPlaces(body, type);
      _logger.finest('Local Restaurants retrieved successfully.');
      return _restaurants;
    } 
    _hotels = mapGooglePlacesToLocalPlaces(body, type);
    _logger.finest('Local Hotels retrieved successfully.');
    return _hotels;
  }
}
