import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/pages/event/event_presenter.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class EventController extends Controller {
  EventPresenter _eventPresenter;
  Event _event;
  User _user;
  bool _isRegistered;
  final bool _isUserEvent;
  bool get isRegistered => _isRegistered;

  Event get event => _event;
  EventController(eventRepo, this._event, this._user, this._isUserEvent) {
    _eventPresenter = EventPresenter(eventRepo);
    _isRegistered = false;
    initListeners();
    _getIsRegistered();
  }

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
    showGenericSnackbar(getScaffoldKey(), e.message);
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
      Navigator.of(getContext()).pushReplacementNamed('/map', arguments: {'event': _event});
    } else {
      _launchMaps();
    }
  }

  void _getIsRegistered() {
    startLoading();
    _eventPresenter.isRegistered(uid: _user.uid, eventId: _event.id);
  }

  void handleRegistration() {
    resumeLoading();
    if (_isRegistered) {
      _eventPresenter.unRegisterFromEvent(uid: _user.uid, eventId: _event.id);
    } else {
      _eventPresenter.registerForEvent(uid: _user.uid, eventId: _event.id);
    }
  }

  /// Launches Apple Maps or Google Maps, whichever is available with the 
  /// [event.location] to navigate to the event if not a race
  _launchMaps() async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${event.location.lat},${event.location.lon}';
    String appleUrl = 'https://maps.apple.com/?sll=${event.location.lat},${event.location.lon}&z=10&t=s';

    if (await canLaunch(googleUrl)) {
      logger.info('Launching Google Maps: $googleUrl');
      await launch(googleUrl);

    } else if (await canLaunch(appleUrl)) {
      logger.info('Launching Apple Maps: $appleUrl');
      await launch(appleUrl);

    } else {
      showGenericSnackbar(getScaffoldKey(), 'A problem occured.');
    }
  }

  @override
  void dispose() {
    _eventPresenter.dispose();
    super.dispose();
  }
}
