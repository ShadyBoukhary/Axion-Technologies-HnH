// Shady Boukhary

import 'dart:async';

import 'package:hnh/domain/entities/coordinates.dart';

/// Abstract class that defines the expected behavior of an [AuthenticationRepository]
/// A repository tasked with user authentication and registration
/// To be implemented in the Data layer
abstract class DirectionsRepository {

  /// Gets directions between the first point in the [coordinates] and the last point
  /// in the [coordinates], passing through every [coordinate] in between.
  Future<dynamic> getDirections(List<Coordinates> coordinates);
}
