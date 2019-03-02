import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'package:hnh/domain/repositories/event_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hnh/data/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

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
  Future<List<Event>> getAllEvents({Map<String, String> queryParams}) async {

    http.Response response;
    List<Event> events;
    List<dynamic> body;
    Uri uri = Uri.http(Constants.baseUrlNoPrefix, Constants.eventsPathOnly, queryParams != null ? queryParams : {});

    try {
      response = await http.get(uri);
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
    if (body.length == 0) {
      return List<Event>();
    }
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
    Map<String, String> params = {'uid': uid};

    try {
      List<Event> events = await getAllEvents(queryParams: params);
      return events;

    } catch(error) {
      _logger.warning('Could not retrieve user events.', error);
      rethrow;
    }
  }
  

  @override
  Future<List<EventRegistration>> getEventRegistrationsByUser({String uid}) async {

    List<dynamic> body;
    http.Response response;
    try {
      response = await http.get(Constants.eventRegistrationsRoute, headers: { uid: uid });

      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(body['message'], response.statusCode, body['statusText']);
      }
    } catch(error) {
      _logger.warning('Could not register for event.', error);
      rethrow;
    }

    body = jsonDecode(response.body);
    List<EventRegistration> eventRegistrations = List.from(body.map((item) => EventRegistration.fromJson(item)));
    return eventRegistrations;
  }

  @override
  Future<void> registerForEvent({@required EventRegistration eventRegistration}) async {

    try {
      http.Response response = await http.post(Constants.eventRegistrationsRoute, body: eventRegistration.toJson2());

      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(body['message'], response.statusCode, body['statusText']);
      }
    } catch(error) {
      _logger.warning('Could not register for event.', error);
      rethrow;
    }
  }
}
