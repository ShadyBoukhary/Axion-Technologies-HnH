import 'package:flutter/foundation.dart';
import 'package:hnh/domain/repositories/authentication_repository.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/domain/entities/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logging/logging.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'dart:io';

class DataAuthenticationRepository implements AuthenticationRepository {
  // Members
  static DataAuthenticationRepository _instance =
      DataAuthenticationRepository._internal();
  Logger _logger;

  // Constructors
  DataAuthenticationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      print('${record.loggerName}: ${record.level.name}: ${record.message}');
    });
  }

  factory DataAuthenticationRepository() => _instance;

  // AuthenticationRepository Methods

  void register({@required String username, @required String password}) async {
    try {
      http.Response response = await http.post(Constants.usersRoute,
          body: {'email': username, 'password': password});
    } catch (error) {
      rethrow;
    }
  }

  Future<void> authenticate(
      {@required String username, @required String password}) async {
    try {
      // invoke http request to login and convert body to map
      http.Response response = await http.post(Constants.loginRoute,
          body: {'email': username, 'password': password});
      Map<String, dynamic> body = jsonDecode(response.body);

      // if the user was not authenticated, throw error
      if (response.statusCode != 200) {
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }
      // convert json to User and save credentials in local storage
      User user = User.fromMap(body['user']);
      _saveCredentials(token: body['token'], user: user);
    } on http.ClientException catch (error) {
      // handle any 404's
      _logger.shout('An error occured while authenticating the user.', error);
      rethrow;

      // handle no internet connection
    } on SocketException {
      _logger.warning('Internet connection could not be established.');
      throw Exception('Internet connection could not be established.');
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuthenticated = preferences.getBool(Constants.isAuthenticatedKey);
      return isAuthenticated;
    } catch (error) {
      return false;
    }
  }

  void resetPassword() {}

  void logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove(Constants.isAuthenticatedKey);
      preferences.remove(Constants.tokenKey);
      _logger.finest('Logout successful.');
    } catch (error) {
      _logger.warning('Could not log out.', error);
    }
  }

  Future<User> getCurrentUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User user = User.fromMap(jsonDecode(preferences.getString(Constants.userKey)));
      return user;
    } catch (error) {
      _logger.severe('Could not retrieve current user.', error);
      rethrow;
    }
  }

  void _saveCredentials({@required String token, @required User user}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await Future.wait([
        preferences.setString(Constants.tokenKey, token),
        preferences.setBool(Constants.isAuthenticatedKey, true),
        preferences.setString(Constants.userKey, user.toMap().toString())
      ]);
      _logger.finest('Credentials successfully stored.');
    } catch (error) {
      _logger.warning('Credentials could not be stored.');
    }
  }
}
