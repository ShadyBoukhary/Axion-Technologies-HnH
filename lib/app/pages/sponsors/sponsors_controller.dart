import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/app/pages/sponsors/sponsors_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/sponsor.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:logging/logging.dart';
import 'package:hnh/domain/entities/hhh.dart';

class SponsorsController extends Controller {
  SponsorsPresenter _sponsorsPresenter;
  User _currentUser;
  HHH _currentHHH;
  List<Sponsor> _sponsors;

  DateTime get eventTime => _currentHHH?.eventTime;
  User get currentUser => _currentUser;
  List<Sponsor> get sponsors => _sponsors;
  Logger logger;
  bool userRetrieved;
  bool hhhRetrieved;

  SponsorsController(hhhRepository, sponsorRepository, authRepository) {
    _sponsorsPresenter =  SponsorsPresenter(hhhRepository, sponsorRepository, authRepository);
    _sponsors = List<Sponsor>();
    initListeners();
    isLoading = true;
    userRetrieved =hhhRetrieved = false;
    retrieveData();
  }

  void initListeners() {
    _sponsorsPresenter.getHHHOnNext = (HHH hhh, List<Sponsor> sponsors) {
      _currentHHH = hhh;
      _sponsors = sponsors;
    };

    _sponsorsPresenter.getHHHOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.message, isError: true);
      print(e);
    };

    _sponsorsPresenter.getHHHOnComplete = () {
      hhhRetrieved = true;
      if (userRetrieved)
        dismissLoading();
    };

    _sponsorsPresenter.getUserOnNext = (User user) {
      _currentUser = user;
    };

    _sponsorsPresenter.getUserOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getStateKey(), e.message, isError: true);
      print(e);
    };

    _sponsorsPresenter.getUserOnComplete = () {
      userRetrieved = true;
      if (hhhRetrieved)
        dismissLoading();
    };
  }

  void retrieveData() {
    _sponsorsPresenter.getCurrentHHH();
    _sponsorsPresenter.getUser();
  }

  void dispose() {
    _sponsorsPresenter.dispose();
    super.dispose();
  }
}