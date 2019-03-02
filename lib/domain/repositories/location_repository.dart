import 'package:hnh/domain/entities/location.dart';
import 'dart:async';

abstract class LocationRepository {
  Future<Location> getLocation();
}