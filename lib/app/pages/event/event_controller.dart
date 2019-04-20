import 'package:flutter/material.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/pages/event/event_presenter.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';
import 'package:hnh/domain/entities/hhh.dart';
import 'package:hnh/app/utils/constants.dart';
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

    _eventPresenter.isRegisteredOnError = (e) {
      print(e);
      dismissLoading();
    };

    _eventPresenter.isRegisteredOnComplete = () {
      dismissLoading();
    };

    _eventPresenter.registerOnError = (e) {
      // TODO: show the user the error
      print(e);
      dismissLoading();
    };

    _eventPresenter.registerOnComplete = () {
      _isRegistered = true;
      dismissLoading();
    };

    _eventPresenter.unRegisterOnError = (e) {
      // TODO: show the user the error
      print(e);
      dismissLoading();
    };

    _eventPresenter.unRegisterOnComplete = () {
      _isRegistered = false;
      dismissLoading();
    };

  }

  void onSignUpPressed() => Navigator.of(getContext()).pushNamed('/web', arguments: {'title': 'Registration', 'url': HHHConstants.registrationUrl});

  void onStartNavigationPressed() {
    Navigator.of(getContext()).pushReplacementNamed('/map', arguments: {'event': _event});
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
    
  @override
  void dispose() {
    _eventPresenter.dispose();
    super.dispose();
  }
}