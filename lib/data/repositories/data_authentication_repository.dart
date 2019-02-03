import 'package:flutter/foundation.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:http/http.dart' as http;

class DataAuthenticationRepository implements AuthenticationRepository {
  // Members
  static DataAuthenticationRepository _instance =
      DataAuthenticationRepository._internal();

  // Constructors
  DataAuthenticationRepository._internal();
  factory DataAuthenticationRepository() => _instance;

  // AuthenticationRepository Methods

  void register({@required String username, @required String password}) {}

  void authenticate({@required String username, @required String password}) async {
    //http.Response response = await http.post(Constants.loginRoute, body: {'email': username, 'password': password});
    try {
      http.Response response = await http.post(Constants.usersRoute, body: {'email': username, 'password': password});
      print(response.toString());
    } catch (error) {
      rethrow;
    }

  }

  bool isAuthenticated() {}

  void resetPassword() {}

  void logout() {}
}
