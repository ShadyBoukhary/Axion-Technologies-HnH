import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/event/event_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';
import 'package:hnh/domain/entities/hhh.dart';

class EventController extends Controller {
  EventPresenter _eventPresenter;

  EventController(eventRepo) {
    _eventPresenter = EventPresenter(eventRepo);
    initListeners();
  }

  void initListeners() {

    _eventPresenter.registerOnError = (e) {
      // TODO: show the user the error
      print(e);
      dismissLoading();
    };

    _eventPresenter.registerOnComplete = () {
      dismissLoading();
    };

  }

  void onSignUpPressed() {
    startLoading();
    //_eventPresenter.registerForEvent();
  }

  void dispose() {
    _eventPresenter.dispose();
  }
}