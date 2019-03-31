import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/home/home_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';
import 'package:hnh/domain/entities/hhh.dart';

class HomeController extends Controller {

  HomePresenter _homePresenter;
  User _currentUser;
  HHH _currentHHH;

  DateTime get eventTime => _currentHHH?.eventTime;
  User get currentUser => _currentUser;
  Logger logger;
  bool userRetrieved;
  bool hhhRetrieved;

  HomeController(hhhRepository, sponsorRepository, authRepository) {
    _homePresenter = HomePresenter(hhhRepository, sponsorRepository, authRepository);
    initListeners();
    isLoading = true;
    userRetrieved = hhhRetrieved = false;
    retrieveData();
  }

  void initListeners() {
    _homePresenter.getHHHOnNext = (HHH hhh) {
      _currentHHH = hhh;
    };

    _homePresenter.getHHHOnError = (e) {
      // TODO: show the user the error
      dismissLoading();
      print(e);
    };

    _homePresenter.getHHHOnComplete = () {
      hhhRetrieved = true;
      if (userRetrieved)
        dismissLoading();
    };

    _homePresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _homePresenter.getUserOnError = (e) {
      dismissLoading();
      // TODO: show the user the error
      print(e);
    };

    _homePresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (hhhRetrieved)
        dismissLoading();
    };
  }

  void retrieveData() {
    _homePresenter.getCurrentHHH();
    _homePresenter.getUser();
  }

  void dispose() {
    _homePresenter.dispose();
  }
}
