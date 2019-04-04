// Shady Boukhary

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';

/// Retrieves [LocalPlaces] for the user.
abstract class LocalPlacesRepository {

  /// Retrieves all local [LocalPlace]s that are restaurants using [latlon].
  Future<List<LocalPlace>> getLocalRestaurants({@required Coordinates latlon});

  /// Retrieves all local [LocalPlace]s that are hotels using [latlon].
  //Future<List<LocalPlace>> getLocalHotels({@required Coordinates latlon});
}