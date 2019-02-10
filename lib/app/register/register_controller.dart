import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/app/register/register_presenter.dart';
import 'package:hnh/domain/entities/user.dart';

class RegisterController extends Controller {
  String _firstName;
  String _lastName;
  String _userEmail;
  String _userPassword;
  dynamic _context;

  AuthenticationRepository _authenticationRepository;
  RegisterPresenter _registerPresenter;

  RegisterController() {
    // _authenticationRepository = AuthenticationRepository();
    _registerPresenter = RegisterPresenter(_authenticationRepository);
    _firstName = '';
    _lastName = '';
    _userEmail = '';
    _userPassword = '';

    initListeners();
  }

  void initListeners() {
    _registerPresenter.registerOnComplete = () {
      print("Complete: Registration success.");
    };

    _registerPresenter.registerOnError = () {
      print("ERROR: Registration failed.");
    };
  }

  void register(context) {
    _context = context;

    _registerPresenter.register(
        firstName: _firstName,
        lastName: _lastName,
        email: _userEmail,
        password: _userPassword);
  }
}
