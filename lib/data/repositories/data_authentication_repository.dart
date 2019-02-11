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

/// `DataAuthenticationRepository` is the implementation of `AuthenticationRepository` present
/// in the Domain layer. It communicates with the server, making API calls to register, login, logout, and
/// store a `User`.
class DataAuthenticationRepository implements AuthenticationRepository {

  // Members
  /// Singleton object of `DataAuthenticationRepository`
  static DataAuthenticationRepository _instance = DataAuthenticationRepository._internal();
  Logger _logger;

  // Constructors
  DataAuthenticationRepository._internal() {
    _logger = Logger('DataAuthenticationRepository');
  }

  factory DataAuthenticationRepository() => _instance;

  // AuthenticationRepository Methods

  /// Registers a `User` using a [email] and a [password] by making an API call to the server.
  /// It is asynchronous and can throw an `APIException` if the statusCode is not 200.
  Future<void> register({@required String firstName, @required String lastName, @required String email, @required String password}) async {
    try {
      http.Response response = await http.post(Constants.usersRoute, body: {'firstName': firstName, 'lastName': lastName,'email': email, 'password': password});
      Map<String, dynamic> body = jsonDecode(response.body);

      // check whether registration was successful
      if (response.statusCode != 200) {
        throw APIException(body['message'], response.statusCode, body['statusText']);
      }
      _logger.finest('Registration is successful');
    } catch (error) {
      _logger.warning('Could not register new user.', error);
      rethrow;
    }
  }

  /// Logs in a `User` using a [email] and a [password] by making an API call to the server.
  /// It is asynchronous and can throw an `APIException` if the statusCode is not 200.
  /// When successful, it attempts to save the credentials of the `User` to local storage by
  /// calling [_saveCredentials]. Throws an `Exception` if an Internet connection cannot be
  /// established. Throws a `ClientException` if the http object fails.
  Future<void> authenticate({@required String email, @required String password}) async {
    try {
      // invoke http request to login and convert body to map
      http.Response response = await http.post(Constants.loginRoute, body: {'email': email, 'password': password});
      Map<String, dynamic> body = jsonDecode(response.body);

      // if the user was not authenticated, throw error
      if (response.statusCode != 200) {
        throw APIException(
            body['message'], response.statusCode, body['statusText']);
      }
      _logger.finest('Login Successful.');
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

  /// Returns whether the current `User` is authenticated.
  Future<bool> isAuthenticated() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool isAuthenticated = preferences.getBool(Constants.isAuthenticatedKey);
      return isAuthenticated;
    } catch (error) {
      return false;
    }
  }

  void resetPassword() {
    throw Exception('Not implemented.');
  }
  /// Logs the current `User` out by clearing credentials.
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

  /// Returns the current authenticated `User` from `SharedPreferences`.
  Future<User> getCurrentUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    User user = User.fromMap(jsonDecode(preferences.getString(Constants.userKey)));
    return user;

  }
  /// Saves the [token] and the [user] in `SharedPreferences`.
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
