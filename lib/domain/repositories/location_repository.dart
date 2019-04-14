import 'package:hnh/domain/entities/location.dart';
import 'package:location/location.dart' as lib;
import 'dart:async';
import 'package:rxdart/rxdart.dart';

abstract class LocationRepository {
  Future<Location> getLocation();
  Observable<lib.LocationData> onLocationChanged();
  void enableDevice();
}