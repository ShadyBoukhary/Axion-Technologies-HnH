

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hnh/domain/entities/coordinates.dart';

LatLng mapCoordinatesToLatLng(Coordinates coordinate) {
  return LatLng(coordinate.numLat, coordinate.numLon);
}

List<LatLng> mapCoordinatesListToLatLngList(List<Coordinates> coordinates) {
  return coordinates.map((coordinate) => mapCoordinatesToLatLng(coordinate)).toList();
}