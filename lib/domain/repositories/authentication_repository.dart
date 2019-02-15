import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/user.dart';

/// Abstract class that defines the expected behavior of an [AuthenticationRepository]
/// A repository tasked with user authentication and registration
/// To be implemented in the Data layer
abstract class AuthenticationRepository {
  /// Registers a new user using the provided [username] and [password]
  Future<void> register({@required String firstName, @required String lastName, @required String email, @required String password});

  /// Authenticates a user using his [username] and [password]
  Future<void> authenticate(
      {@required String email, @required String password});

  /// Returns a `Future<bool>` whether the current user is authenticated
  Future<bool> isAuthenticated();

  // Returns the current authenticated `User` wrapped in a `Future`
  Future<User> getCurrentUser();

  /// Resets the password of a user
  void resetPassword();

  /// Logs out the user
  Future<void> logout();
}
