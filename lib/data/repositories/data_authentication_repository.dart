import 'package:flutter/foundation.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart';

class DataAuthenticationRepository implements AuthenticationRepository {

  // Members
  static DataAuthenticationRepository _instance = DataAuthenticationRepository._internal();

  // Constructors
  DataAuthenticationRepository._internal();
  factory DataAuthenticationRepository() => _instance;

  // AuthenticationRepository Methods

  void register({@required String username, @required String password}) {

  }

  void authenticate({@required String username, @required String password}) {

  }

  bool isAuthenticated() {

  }

  void resetPassword() {

  }

  void logout() {

  }
}