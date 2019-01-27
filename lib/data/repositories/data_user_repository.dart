import 'package:hnh/domain/repositories/user_repository.dart';
import 'package:hnh/domain/entities/user.dart';
import 'dart:async';

class DataUserRepository implements UserRepository {

  // singleton
  static final DataUserRepository _instance = DataUserRepository._internal();

  DataUserRepository._internal();

  // get singleton instance
  factory DataUserRepository() => _instance;

  void saveUser(User user) {}

  Future<User> getUser(String uid) async {
    // testing only
    // todo: remove when implementing actual method
    Completer completer = Completer<User>();
    completer.complete(User('Shady', 'Boukhary', '876fsa-af35ra-3asdf-4dasd'));
    return completer.future;

  }
  Future<List<User>> getAllUsers() {}
}