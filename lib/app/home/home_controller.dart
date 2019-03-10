import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/home/user_presenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';

class HomeController extends Controller {

  UserPresenter _userPresenter;
  User _currentUser;
  User get currentUser => _currentUser;
  Logger logger;

  HomeController() {
    initListeners();
  }

  void initListeners() {
    _userPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _userPresenter.getUserOnError = () {
      logger.shout("ERROR: Could not retrieve user.");
    };

    _userPresenter.getUserOnComplete = () {
      logger.finest("Completed: User retrieved.");
    };
  }

  void getUser() async {
  }

  void logout(context) {
    // TODO: Sign out user
  }
}
