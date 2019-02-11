import 'package:hnh/domain/entities/location.dart';

abstract class LocationRepository {
  Future<Location> getLocation();
}