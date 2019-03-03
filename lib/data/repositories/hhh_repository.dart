import 'package:hnh/domain/entities/hhh.dart';
import 'package:hnh/domain/repositories/hhh_repository.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:logging/logging.dart';
import 'package:http/http.dart' as http;
import 'package:hnh/data/utils/constants.dart';
import 'dart:convert';
import 'dart:async';

class DataHHHRepository implements HHHRepository {

  // singleton
  static final DataHHHRepository _instance = DataHHHRepository._internal();
  Logger _logger;

  DataHHHRepository._internal() {
    _logger =Logger('DataHHHRepository');
  }
  // get singleton instance
  factory DataHHHRepository() => _instance;


  /// Retrieve all [HHH] events throughout the years. Throws an [APIException].
  @override
  Future<List<HHH>> getAllHHHs() async {
    http.Response response;
    List<HHH> hhhs;
    List<dynamic> body;

    try {
      response = await http.get(Constants.allHHHRoute);

      // check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }
    } catch (error) {
      _logger.warning('Could not retrieve HHHs.', error);
      rethrow;
    }
    
    body = jsonDecode(response.body);
    if (body.length == 0) {
      return List<HHH>();
    }

    hhhs = List.from(body.map((map) => HHH.fromJson(map)));
    _logger.finest('HHHs retrieved successfully.');
    return hhhs;
  }

  /// Returns current year's [HHH] event. e.g `hhh.id == '2019`
  @override
  Future<HHH> getCurrentHHH() async {
    http.Response response;
    HHH hhh;
    Map<String, dynamic> body;

    try {
      response = await http.get(Constants.currentHHHRoute);

      // check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }
    } catch (error) {
      _logger.warning('Could not retrieve current HHH.', error);
      rethrow;
    }
    
    // convert body to `List<dynamic>`
    body = jsonDecode(response.body);
    hhh = HHH.fromJson(body);

    _logger.finest('Current HHH retrieved successfully.');
    return hhh;
  }

}