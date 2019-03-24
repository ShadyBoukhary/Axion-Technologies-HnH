import 'package:flutter/widgets.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/events/events_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:logging/logging.dart';

class EventsController extends Controller {
  EventsPresenter _eventsPresenter;
  List<Event> _featuredEvents;
  List<Event> _upcomingEvents;
  User _currentUser;
  Logger logger;
  bool userRetrieved;
  bool eventsRetrieved;

  User get currentUser => _currentUser;
  List<Event> get featuredEvents => _featuredEvents;
  List<Event> get upComingEvents => _upcomingEvents;


  EventsController(authRepository, eventRepository) {
    _eventsPresenter = EventsPresenter(authRepository, eventRepository);
    _featuredEvents = List<Event>();
    _upcomingEvents = List<Event>();
    initListeners();
    startLoading();
    userRetrieved = eventsRetrieved = false;
    retrieveData();
  }

  void initListeners() {

    _eventsPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _eventsPresenter.getUserOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _eventsPresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (eventsRetrieved)
        dismissLoading();
    };

    _eventsPresenter.getEventsOnNext = (List<Event> featuredEvents, List<Event> upcomingEvents) {
      _featuredEvents = featuredEvents;
      _upcomingEvents = upcomingEvents;
    };

    _eventsPresenter.getEventsOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _eventsPresenter.getEventsOnComplete = () {
      eventsRetrieved = true;
      if (userRetrieved)
        dismissLoading();
    };
  }

  void openEvent(event) {
    Navigator.of(context).pushNamed('/event', arguments: {'event': event, 'user': _currentUser});
  }

  void retrieveData() {
    _eventsPresenter.getUser();
    _eventsPresenter.getAllEvents();
  }

  void dispose() {
    _eventsPresenter.dispose();
  }
}