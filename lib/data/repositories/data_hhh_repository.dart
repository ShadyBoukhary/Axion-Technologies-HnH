import 'package:hnh/domain/entities/hhh.dart';
import 'package:hnh/domain/repositories/hhh_repository.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/utils/http_helper.dart';
import 'dart:async';

class DataHHHRepository implements HHHRepository {

  // singleton
  static final DataHHHRepository _instance = DataHHHRepository._internal();
  Logger _logger;
  HHH _currentHHH;

  DataHHHRepository._internal() {
    _logger =Logger('DataHHHRepository');
  }
  // get singleton instance
  factory DataHHHRepository() => _instance;


  /// Retrieve all [HHH] events throughout the years. Throws an [APIException].
  @override
  Future<List<HHH>> getAllHHHs() async {
    List<HHH> hhhs;
    List<dynamic> body;

    try {
      body = await HttpHelper.invokeHttp2(Constants.allHHHRoute, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve HHHs.', error);
      rethrow;
    }
    
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

    if (_currentHHH != null) {
      return _currentHHH;
    }
    
    HHH hhh;
    Map<String, dynamic> body;

    try {
      body = await HttpHelper.invokeHttp(Constants.currentHHHRoute, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve current HHH.', error);
      rethrow;
    }
    
    hhh = HHH.fromJson(body);

    _logger.finest('Current HHH retrieved successfully.');
    return hhh;
  }

}