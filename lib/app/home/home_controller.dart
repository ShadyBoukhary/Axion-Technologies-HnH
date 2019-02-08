import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/home/user_presenter.dart';
import 'package:hnh/data/repositories/data_user_repository.dart';
import 'package:hnh/domain/entities/user.dart';

import 'package:hnh/data/repositories/data_authentication_repository.dart';
class HomeController extends Controller {

  UserPresenter _userPresenter;
  DataUserRepository _dataUserRepository;
  int _counter;
  User _currentUser;
  bool _hidden; // hide user UI until retrieved
  bool get hidden => _hidden;
  User get currentUser => _currentUser;
  int get counter => _counter;

  HomeController() {
    _dataUserRepository = DataUserRepository();
    _userPresenter = UserPresenter(_dataUserRepository);
    _counter = 0;
    _hidden = true;
    initListeners();
  }

  void initListeners() {
    _userPresenter.getUserOnNext = (User user) {
      _currentUser = user;
      _hidden = false;
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
  
  void incrementCounter() {
    _counter++;
  } 
}
