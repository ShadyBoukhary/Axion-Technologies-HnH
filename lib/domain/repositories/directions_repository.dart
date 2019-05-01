// Shady Boukhary

import 'dart:async';

import 'package:hnh/domain/entities/coordinates.dart';

/// A repository tasked with user authentication and registration
abstract class DirectionsRepository {
  /// Gets directions between the first point in the [Coordinates] and the last point
  /// in the [Coordinates], passing through every [Coordinates] in between.
  Future<dynamic> getDirections(List<Coordinates> coordinates);
}
