import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/repositories/event_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hnh/data/utils/constants.dart';

class DataEventRepository implements EventRepository {
  // Members

  /// Singleton object of `DataEventRepository`
  static DataEventRepository _instance = DataEventRepository._internal();
  Logger _logger;

  // Constructors
  DataEventRepository._internal() {
    _logger = Logger('DataEventRepository');
  }

  factory DataEventRepository() => _instance;

  /// Retrieves all HnH events from the server
  @override
  Future<List<Event>> getAllEvents() async {

    http.Response response;
    List<Event> events;
    List<dynamic> body;

    try {
      response = await http.get(Constants.eventsRoute);

      // check for any errors
      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }
    } catch (error) {
      _logger.warning('Could not retrieve events.', error);
      rethrow;
    }
    
    // convert body to `List<Event>`
    body = jsonDecode(response.body);
    bodyToListMap(body);
    events = List.from(body.map((map) => Event.fromJson(map)));
    _logger.finest('Events retrieved successfully.');
    return events;
  }

  /// Fixes an issue where the [body] returned by the API is somehow mapped to a
  /// `List<dynamic>` for the route instead of a `List<Map<String, dynamic>>`. This
  /// converts the route of the `Event` to a `List<Map<String, dynamic>>`.
  void bodyToListMap(List<dynamic> body) {
    body.forEach((item) {
      List<Map<String, dynamic>> route = List<Map<String, dynamic>>();
      (item['route'] as List<dynamic>).forEach((coords) {
        route.add(coords);
      });
      item['route'] = route;
    });
  }

  @override
  Future<List<Event>> getUserEvents({String uid}) async {
    // TODO: implement getUserEvents
    return null;
  }
}
