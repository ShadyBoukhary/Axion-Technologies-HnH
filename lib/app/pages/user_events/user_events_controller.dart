import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/user_events/user_events_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';

class UserEventsController extends Controller {
  UserEventsPresenter _eventsPresenter;
  List<Event> _events;
  User _currentUser;
  bool isLoading = false;

  User get currentUser => _currentUser;
  List<Event> get events => _events;

  UserEventsController(eventRepository, this._currentUser)
      : _eventsPresenter = UserEventsPresenter(eventRepository) {
    _events = List<Event>();
    initListeners();
    retrieveData();
  }

  void initListeners() {
    _eventsPresenter.getUserEventsOnNext = (List<Event> events) {
      _events = events;
    };

    _eventsPresenter.getUserEventsOnError = (e) {
      showGenericSnackbar(getStateKey(), e.message, isError: true);
      print(e);
    };

    _eventsPresenter.getUserEventsOnComplete = () {};
  }

  void openEvent(event) {
    Navigator.of(getContext())
        .pushNamed('/event', arguments: {'event': event, 'user': _currentUser});
  }

  void retrieveData() {
    _eventsPresenter.getUserEvents(uid: _currentUser.uid);
  }

  @override
  void dispose() {
    _eventsPresenter.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    // Retrieve data again when user navigates back to this page
    // In case the user removed an event from favorites
    retrieveData();
    super.didPopNext();
  }
}
