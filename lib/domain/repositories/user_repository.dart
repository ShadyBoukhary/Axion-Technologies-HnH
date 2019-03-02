import 'package:hnh/domain/entities/user.dart';
import 'dart:async';

abstract class UserRepository {
  void saveUser(User user);
  Future<User> getUser(String uid);
  Future<List<User>> getAllUsers();
}