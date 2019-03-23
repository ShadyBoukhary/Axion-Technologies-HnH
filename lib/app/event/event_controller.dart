import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/event/event_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';
import 'package:hnh/domain/entities/hhh.dart';

class EventController extends Controller {
  EventPresenter _eventPresenter;
  User _currentUser;
  HHH _currentHHH;

  DateTime get eventTime => _currentHHH?.eventTime;
  User get currentUser => _currentUser;
  Logger logger;
  bool userRetrieved;
  bool hhhRetrieved;

  EventController(hhhRepository, sponsorRepository, authRepository) {
    _eventPresenter =
        EventPresenter(hhhRepository, sponsorRepository, authRepository);
    initListeners();
    isLoading = true;
    userRetrieved =hhhRetrieved = false;
    retrieveData();
  }

  void initListeners() {
    _eventPresenter.getHHHOnNext = (HHH hhh) {
      _currentHHH = hhh;
    };

    _eventPresenter.getHHHOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _eventPresenter.getHHHOnComplete = () {
      hhhRetrieved = true;
      if (userRetrieved)
        dismissLoading();
    };

    _eventPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _eventPresenter.getUserOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _eventPresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (hhhRetrieved)
        dismissLoading();
    };
  }

  void retrieveData() {
    _eventPresenter.getCurrentHHH();
    _eventPresenter.getUser();
  }

  void dispose() {
    _eventPresenter.dispose();
  }
}