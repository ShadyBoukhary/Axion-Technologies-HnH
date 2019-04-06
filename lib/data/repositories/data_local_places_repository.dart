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

    _localPlaces = mapGooglePlacesToLocalPlaces(body, type);
    _logger.finest('Local Places retrieved successfully.');
    return _localPlaces;
  }
}
