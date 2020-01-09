import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/events/events_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';
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

  EventsController(authRepository, eventRepository)
      : _eventsPresenter = EventsPresenter(authRepository, eventRepository),
        super() {
    _featuredEvents = List<Event>();
    _upcomingEvents = List<Event>();
    userRetrieved = eventsRetrieved = false;
    retrieveData();
  }

  @override
  void initListeners() {
    _eventsPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _eventsPresenter.getUserOnError = (e) {
      // TODO: show the user the error
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.message, isError: true);
    };

    _eventsPresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (eventsRetrieved) dismissLoading();
    };

    _eventsPresenter.getEventsOnNext =
        (List<Event> featuredEvents, List<Event> upcomingEvents) {
      _featuredEvents = featuredEvents;
      _upcomingEvents = upcomingEvents;
    };

    _eventsPresenter.getEventsOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.message, isError: true);
    };

    _eventsPresenter.getEventsOnComplete = () {
      eventsRetrieved = true;
      if (userRetrieved) dismissLoading();
    };
  }

  void openEvent(event) {
    Navigator.of(getContext()).pushNamed('/event', arguments: {
      'event': event,
      'user': _currentUser,
      'isUserEvent': false
    });
  }

  void retrieveData() {
    _eventsPresenter.getUser();
    _eventsPresenter.getAllEvents();
  }

  @override
  void dispose() {
    _eventsPresenter.dispose();
    super.dispose();
  }
}
