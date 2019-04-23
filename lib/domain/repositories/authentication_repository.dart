// Shady Boukhary

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/user.dart';

/// A repository tasked with user authentication and registration.
abstract class AuthenticationRepository {
  /// Registers a new user using the provided [username] and [password]
  Future<void> register(
      {@required String firstName,
      @required String lastName,
      @required String email,
      @required String password});

  /// Authenticates a user using his [username] and [password]
  Future<void> authenticate(
      {@required String email, @required String password});

  /// Returns whether the [User] is authenticated.
  Future<bool> isAuthenticated();

  /// Returns the current authenticated [User].
  Future<User> getCurrentUser();

  /// Resets the password of a [User]
  Future<void> forgotPassword(String email);

  /// Logs out the [User]
  Future<void> logout();
}
