import 'package:flutter/widgets.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/components/hhDrawer/hhDrawerPresenter.dart';
import 'package:hnh/domain/entities/user.dart';

class HHDrawerController extends Controller {

  HHDrawerPresenter _drawerPresenter;
  User _currentUser;
  User get user => _currentUser;

  HHDrawerController(authRepository) {
    _drawerPresenter = HHDrawerPresenter(authRepository);
    initListeners();
    retrieveData();
  }

  void initListeners() {

    _drawerPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _drawerPresenter.getUserOnError = (e) {
      // TODO: show the user the error
      print(e);
    };

    _drawerPresenter.logoutOnComplete = () => navigate('/login', getContext());
  }

  void retrieveData() => _drawerPresenter.getUser();
  void navigate(String page, context) =>  Navigator.of(context).pushReplacementNamed(page);
  void navigateWithArgs(String page, context, args) =>  Navigator.of(context).pushReplacementNamed(page, arguments: args);
  void logout() => _drawerPresenter.logout();
  void dispose() { 
    _drawerPresenter.dispose(); 
    super.dispose();
  }
}
