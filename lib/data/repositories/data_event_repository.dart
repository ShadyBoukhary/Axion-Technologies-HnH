import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'package:hnh/domain/repositories/event_repository.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:hnh/data/utils/http_helper.dart';

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

  /// Retrieves all the [Event]'s from the server. If a `Map` containing [params] is given,
  /// it is used as query parameters for the API. Throws an [APIException] if an API-related exception
  /// occurs. Returns a `List<Event>>` that could be empty.
  @override
  Future<List<Event>> getAllEvents({Map<String, String> params}) async {

    List<Event> events;
    List<dynamic> body;
    Uri uri = Uri.http(Constants.baseUrlNoPrefix, Constants.eventsPathOnly, params != null ? params : {});

    try {
      body = await HttpHelper.invokeHttp2(uri, RequestType.get);
    } catch (error) {
      _logger.warning('Could not retrieve events.', error);
      rethrow;
    }
    
    if (body.length == 0) {
      return List<Event>();
    }

    events = List.from(body.map((map) => Event.fromJson(map)));
    _logger.finest('Events retrieved successfully.');
    return events;
  }

  /// Returns a list of [Event]'s in which a [User] is registered in using their id [uid].
  @override
  Future<List<Event>> getUserEvents({String uid}) async {
    Map<String, String> params = {'uid': uid};

    try {
      List<Event> events = await getAllEvents(params: params);
      return events;

    } catch(error) {
      _logger.warning('Could not retrieve user events.', error);
      rethrow;
    }
  }
  
  /// Registers a `User` in an `Event` using a [eventRegistration]. Adds the [eventRegistration] to
  /// the `EventRegistration` collection. Throws an [APIException] if registration fails. Otherwise, nothing
  /// is returned.
  @override
  Future<void> registerForEvent({@required EventRegistration eventRegistration}) async {

    try {
      await HttpHelper.invokeHttp(Constants.eventRegistrationsRoute, RequestType.post, body: eventRegistration.toJson2());
    } catch(error) {
      _logger.warning('Could not register for event.', error);
      rethrow;
    }
  }

  @override
  Future<void> unRegisterFromEvent({EventRegistration eventRegistration}) async {
    Uri uri = Uri.http(Constants.baseUrlNoPrefix, Constants.eventRegistrationsPathOnly, eventRegistration.toJson2());
    try {
      await HttpHelper.invokeHttp(uri, RequestType.delete);
    } catch(error) {
      _logger.warning('Could not unregister from event.', error);
      rethrow;
    }
  }
}
