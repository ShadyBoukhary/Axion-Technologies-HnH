import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:hnh/domain/repositories/user_repository.dart';
import 'dart:async';

class UserUseCase extends UseCase<User, UserUseCaseParams> {
  UserRepository _userRepository;

  UserUseCase(this._userRepository);

  @override
  Future<Observable<User>> buildUseCaseObservable(UserUseCaseParams params) async {
    final StreamController<User> controller = StreamController();
    try {
      User user = await _userRepository.getUser(params._uid);
      controller.add(user);
      controller.close();
    } catch (e) {
      print(e);
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

class UserUseCaseParams {
  String _uid;
  String get uid => _uid;

  UserUseCaseParams(this._uid);
}
