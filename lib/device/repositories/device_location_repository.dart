import 'package:hnh/domain/repositories/location_repository.dart';
import 'package:hnh/domain/entities/location.dart';
import 'dart:async';
import 'package:location/location.dart' as LocationLib;
import 'package:rxdart/rxdart.dart';

class DeviceLocationRepository implements LocationRepository {

  // instance
  static final DeviceLocationRepository _instance = DeviceLocationRepository._internal();
  final LocationLib.Location _locationDevice;

  DeviceLocationRepository._internal() : _locationDevice = LocationLib.Location();

  factory DeviceLocationRepository() => _instance;

  /// Retrieves the device's current [Location]
  Future<Location> getLocation() async {
    try {
      LocationLib.LocationData location = await _locationDevice.getLocation();
      return Location.withoutTime(location.latitude.toString(), location.longitude.toString(), location.speed);
    } catch(e) {
      rethrow;
    }
  }

  /// Returns an [Observable<LocationData>] that fires every time the [Location] has changed
  Observable<LocationLib.LocationData> onLocationChanged() => Observable(_locationDevice.onLocationChanged());

  @override
  void enableDevice() async {
    bool enabled = await _locationDevice.serviceEnabled();
    bool hasPermission = await _locationDevice.hasPermission();
    if (!enabled) {
      await _locationDevice.requestService();
    }
    if (!hasPermission) {
      await _locationDevice.requestPermission();
    }
  }

}
