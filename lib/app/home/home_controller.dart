import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/home/user_presenter.dart';
import 'package:hnh/data/repositories/data_user_repository.dart';
import 'package:hnh/domain/entities/user.dart';

import 'package:hnh/data/repositories/data_authentication_repository.dart';
class HomeController extends Controller {

  UserPresenter _userPresenter;
  DataUserRepository _dataUserRepository;
  User _currentUser;
  User get currentUser => _currentUser;

  HomeController() {
    _dataUserRepository = DataUserRepository();
    _userPresenter = UserPresenter(_dataUserRepository);
    initListeners();
  }

  void initListeners() {
    _userPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _userPresenter.getUserOnError = () {
      print("ERROR: Could not retrieve user.");
    };

    _userPresenter.getUserOnComplete = () {
      print("Completed: User retrieved.");
    };
  }

  void getUser() async {
    await DataAuthenticationRepository().register(username: 'shsady', password: 'shadya');
    _userPresenter.getUser('does-not-matter-id-for-testing');
  }

  void logout(context) {
    print("HAHAHA No function yet!!");
  }
}
