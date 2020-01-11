import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/home/home_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/hhh.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';

class HomeController extends Controller {
  HomePresenter _homePresenter;
  User _currentUser;
  HHH _currentHHH;

  DateTime get eventTime => _currentHHH?.eventTime;
  User get currentUser => _currentUser;
  Logger logger;
  bool userRetrieved;
  bool hhhRetrieved;
  bool isLoading;

  HomeController(hhhRepository, sponsorRepository, authRepository)
      : _homePresenter =
            HomePresenter(hhhRepository, sponsorRepository, authRepository) {
    isLoading = true;
    userRetrieved = hhhRetrieved = false;
    retrieveData();
  }

  void initListeners() {
    _homePresenter.getHHHOnNext = (HHH hhh) {
      _currentHHH = hhh;
    };

    _homePresenter.getHHHOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.message, isError: true);
    };

    _homePresenter.getHHHOnComplete = () {
      hhhRetrieved = true;
      if (userRetrieved) dismissLoading();
    };

    _homePresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _homePresenter.getUserOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.message, isError: true);
      print(e);
    };

    _homePresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (hhhRetrieved) dismissLoading();
    };
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void retrieveData() {
    _homePresenter.getCurrentHHH();
    _homePresenter.getUser();
  }

  @override
  void dispose() {
    _homePresenter.dispose();
    super.dispose();
  }
}
