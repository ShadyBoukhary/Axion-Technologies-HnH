import 'package:hnh/domain/entities/sponsor.dart';
import 'package:hnh/domain/repositories/sponsor_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/utils/http_helper.dart';
import 'package:hnh/domain/utils/utils.dart';
import 'dart:async';

class DataSponsorRepository implements SponsorRepository {

  // singleton
  static final DataSponsorRepository _instance = DataSponsorRepository._internal();
  Logger _logger;
  List<Sponsor> _currentSponsors;

  DataSponsorRepository._internal() {
    _logger =Logger('DataSponsorRepository');
  }
  // get singleton instance
  factory DataSponsorRepository() => _instance;

  @override
  Future<List<Sponsor>> getSponsors({String year}) async {
    List<Sponsor> sponsors;
    List<dynamic> body;
    Uri uri = Uri.http(Constants.baseUrlNoPrefix, Constants.sponsorsPathOnly, {'year': year});

    try {
      body = await HttpHelper.invokeHttp2(uri, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve Sponsors.', error);
      rethrow;
    }
  
    if (body.length == 0) {
      return List<Sponsor>();
    }

    sponsors = List.from(body.map((map) => Sponsor.fromJson(map)));
    _logger.finest('Sponsors retrieved successfully.');
    return sponsors;
  }

  @override
  Future<List<Sponsor>> getCurrentSponsors() async {
    if (_currentSponsors != null) {
      return _currentSponsors;
    }
    
    return _currentSponsors ?? (_currentSponsors = await getSponsors(year: Utils.currentYear));
  }
}