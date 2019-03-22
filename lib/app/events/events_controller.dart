import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/events/events_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';
import 'package:hnh/domain/entities/hhh.dart';

class EventsController extends Controller {
  EventsPresenter _eventsPresenter;
  User _currentUser;
  HHH _currentHHH;

  DateTime get eventTime => _currentHHH?.eventTime;
  User get currentUser => _currentUser;
  Logger logger;
  bool userRetrieved;
  bool hhhRetrieved;

  EventsController(hhhRepository, sponsorRepository, authRepository) {
    _eventsPresenter =
        EventsPresenter(hhhRepository, sponsorRepository, authRepository);
    initListeners();
    isLoading = true;
    userRetrieved =hhhRetrieved = false;
    retrieveData();
  }

  void initListeners() {
    _eventsPresenter.getHHHOnNext = (HHH hhh) {
      _currentHHH = hhh;
    };

    _eventsPresenter.getHHHOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _eventsPresenter.getHHHOnComplete = () {
      hhhRetrieved = true;
      if (userRetrieved)
        dismissLoading();
    };

    _eventsPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _eventsPresenter.getUserOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _eventsPresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (hhhRetrieved)
        dismissLoading();
    };
  }

  void retrieveData() {
    _eventsPresenter.getCurrentHHH();
    _eventsPresenter.getUser();
  }

  void dispose() {
    _eventsPresenter.dispose();
  }
}