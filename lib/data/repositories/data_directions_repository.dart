import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:hnh/domain/repositories/directions_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/utils/http_helper.dart';
import 'package:hnh/data/mappers/local_places_mapper.dart';

import 'dart:async';

class DataDirectionsRepository implements DirectionsRepository {
  // singleton
  static final DataDirectionsRepository _instance =
      DataDirectionsRepository._internal();
  Logger _logger;
  List<LocalPlace> _restaurants;
  List<LocalPlace> _hotels;

  DataDirectionsRepository._internal() {
    _logger = Logger('DataDirectionsRepository');
  }
  // get singleton instance
  factory DataDirectionsRepository() => _instance;

  @override
  Future getDirections(List<Coordinates> coordinates) async {
    Map<String, dynamic> body;

    // specifiy google api query parameters
    String delimeter = '|via:';
    int offset = coordinates.length ~/ 23;
    String waypoints = 'via:';
    for (int i = 0; i < coordinates.length - 1 - offset; i += offset) {
      if (i <= coordinates.length - 1) {
        waypoints = '$waypoints${coordinates[i]}';
        if (coordinates[i] != coordinates.last) {
          waypoints = '$waypoints$delimeter';
        }
      }
    }
    Map<String, String> query = {
      'origin': coordinates.first.toString(),
      'destination': coordinates.last.toString(),
      'key': Constants.placesApiKey,
      'mode': 'bicycling',
      'waypoints': waypoints
    };

    Uri uri =
        Uri.https(Constants.googleApi, Constants.gooleDirectionsPath, query);
    print(uri.toString());
    try {
      body = await HttpHelper.invokeHttp(uri, RequestType.get);
      // TODO: parse the response
    } catch (error) {
      _logger.warning('Could not retrieve directions.', error);
      rethrow;
    }
  }
}
