import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:hnh/domain/entities/weather.dart';
import 'package:hnh/domain/repositories/local_places_repository.dart';
import 'package:hnh/domain/repositories/weather_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/utils/http_helper.dart';
import 'package:hnh/data/mappers/local_places_mapper.dart';

import 'dart:async';

class DataWeatherRepository implements WeatherRepository {
  // singleton
  static final DataWeatherRepository _instance = DataWeatherRepository._internal();
  Logger _logger;


  DataWeatherRepository._internal() {
    _logger = Logger('DataWeatherRepository');
  }
  // get singleton instance
  factory DataWeatherRepository() => _instance;

  @override
  Future<Weather> getWeather(Coordinates coordinates) async {
    Map<String, dynamic> body;

    // specifiy google api query parameters
    Map<String, String> query = {
      'id': Constants.wichitaFallsId,
      'APPID': Constants.openWeatherKey
    };

    Uri uri = Uri.https(Constants.weatherApi, Constants.weatherLatLonPath, query);
    try {
      body = await HttpHelper.invokeHttp(uri, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve Local Places.', error);
      rethrow;
    }

    Weather weather = Weather.fromMap(body);
    return weather;

  }
}
