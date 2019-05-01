import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/app/utils/google_maps_mapper.dart';

/// Mini Google Map used to display a route or the location of an event on the map
class MiniMap extends StatelessWidget {

  final Event event;
  final Set<Polyline> _polylines;
  final Set<Marker> _markers;

  MiniMap(this.event): _polylines = Set<Polyline>(), _markers = Set<Marker>() {
    initPolylines();
    initMarkers();
  }

  @override
  Widget build(BuildContext context) {
      return mapContainer;
  }

  void initPolylines() {
    _polylines.add(Polyline(
        polylineId: PolylineId(_polylines.length.toString()),
        points: mapCoordinatesListToLatLngList(event.route),
        width: 6,
        color: Colors.red));
  }

    void initMarkers() {
      if (!event.isRace) {
        _markers.add(Marker(
          markerId: MarkerId(_markers.length.toString()),
          position: mapCoordinatesToLatLng(event.location.toCoordinates()),
        ));
      }
  }

  Container get mapContainer => Container(
        height: 250,
        width: 100,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: mapCoordinatesToLatLng(event.location.toCoordinates()),
            zoom: event.isRace ? 9 : 11,
          ),
          polylines: _polylines,
          markers: _markers,
          compassEnabled: false,
          rotateGesturesEnabled: false,
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: false,
        ),
      );
}
