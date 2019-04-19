import 'package:flutter/widgets.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/components/hhDrawer/hhDrawerPresenter.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:package_info/package_info.dart';

class HHDrawerController extends Controller {
  HHDrawerPresenter _drawerPresenter;
  User _currentUser;
  PackageInfo _info;

  User get user => _currentUser;
  String get info => '${_info.appName} v${_info.version}';

  HHDrawerController(authRepository) {
    _drawerPresenter = HHDrawerPresenter(authRepository);
    _info = PackageInfo(appName: '', version: '');
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

  void retrieveData() async {
    _drawerPresenter.getUser();
    _info = await PackageInfo.fromPlatform();

  }

  void navigate(String page, context) =>
      Navigator.of(context).pushReplacementNamed(page);

  void navigateWithArgs(String page, context, args) =>
      Navigator.of(context).pushReplacementNamed(page, arguments: args);

  void logout() => _drawerPresenter.logout();

  void dispose() {
    _drawerPresenter.dispose();
    super.dispose();
  }
}
