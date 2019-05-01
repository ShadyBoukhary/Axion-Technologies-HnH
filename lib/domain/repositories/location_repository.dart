import 'package:hnh/domain/entities/location.dart';
import 'package:location/location.dart' as lib;
import 'dart:async';
import 'package:rxdart/rxdart.dart';

/// Handles operations related to location services.
abstract class LocationRepository {

  /// Retireves the [User]'s current [Location].
  Future<Location> getLocation();

  /// Returns an [Observable] that fires every `5 seconds` with new [Location] data.
  Observable<lib.LocationData> onLocationChanged();

  /// Requests `Location` permissions to be granted by the user.
  void enableDevice();
}