import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/event/event_presenter.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/app/utils/constants.dart';

class EventController extends Controller {
  EventPresenter _eventPresenter;
  Event _event;
  User _user;
  bool _isRegistered;
  final bool _isUserEvent;
  bool finishedLoading; // flag to display map
  bool get isRegistered => _isRegistered;

  Event get event => _event;
  EventController(eventRepo, this._event, this._user, this._isUserEvent)
      : _eventPresenter = EventPresenter(eventRepo),
        super() {
    _isRegistered = false;
    finishedLoading = false;
    _getIsRegistered();
  }

  @override
  void initListeners() {
    _eventPresenter.isRegisteredOnNext = (bool status) {
      _isRegistered = status;
    };

    _eventPresenter.isRegisteredOnError = (e) => handleError(e);
    _eventPresenter.isRegisteredOnComplete = () {
      dismissLoading();
    };

    _eventPresenter.registerOnError = (e) => handleError(e);
    _eventPresenter.registerOnComplete = () {
      _isRegistered = true;
      dismissLoading();
    };

    _eventPresenter.unRegisterOnError = (e) => handleError(e);
    _eventPresenter.unRegisterOnComplete = () {
      _isRegistered = false;
      dismissLoading();
    };
  }

  void handleError(e) {
    dismissLoading();
    showGenericSnackbar(getStateKey(), e.message);
  }

  void onSignUpPressed() =>
      Navigator.of(getContext()).pushNamed('/web', arguments: {
        'title': 'Registration',
        'url': HHHConstants.registrationUrl
      });

  void onStartNavigationPressed() {
    // navigate to maps page if the event is a race
    // otherwise, try to open Google or Apple maps
    if (event.isRace) {
      Navigator.of(getContext())
          .pushReplacementNamed('/map', arguments: {'event': _event});
    } else {
      launchMaps(_event.location, logger, getStateKey());
    }
  }

  void _getIsRegistered() {
    loadOnStart();
    _eventPresenter.isRegistered(uid: _user.uid, eventId: _event.id);
  }

  void handleRegistration() {
    showLoading();
    if (_isRegistered) {
      _eventPresenter.unRegisterFromEvent(uid: _user.uid, eventId: _event.id);
    } else {
      _eventPresenter.registerForEvent(uid: _user.uid, eventId: _event.id);
    }
  }

  @override
  void dispose() {
    _eventPresenter.dispose();
    super.dispose();
  }
}
