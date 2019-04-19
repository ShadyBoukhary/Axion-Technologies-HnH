import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/map/map_presenter.dart';
import 'package:hnh/app/utils/constants.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hnh/app/utils/google_maps_mapper.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/weather.dart';

class MapController extends Controller {
  GoogleMapController _googleMapController;
  MapPresenter _mapPresenter;
  Location _initialPosition;
  Location _currentLocation;
  Weather _currentWeather;
  bool _isInitialSet;
  bool isNavigating;
  Set<Polyline> polylines;
  Set<Marker> markers;
  Event _event;

  LatLng get initial =>
      LatLng(_initialPosition.numLat, _initialPosition.numLon);
  Location get currentLocation => _currentLocation;
  Weather get currentWeather => _currentWeather;

  MapController(locationRepository, weatherRepository, this._event) {
    _mapPresenter = MapPresenter(locationRepository, weatherRepository);
    _currentLocation =
        _initialPosition = Location('33.911614', '-98.496268', '0', 1);
    _currentWeather = Weather.empty();
    polylines = Set<Polyline>();
    markers = Set<Marker>();
    _isInitialSet = false;
    isNavigating = true;
    initListeners();
    initPolylines();
    initMarkers();
    _mapPresenter.startTrackingLocation();
  }

  void initListeners() {
    _mapPresenter.locationOnNext = nextLocationAndWeather;
    _mapPresenter.locationOnComplete = locationTrackingStopped;
    _mapPresenter.locationOnError = locationTrackingError;
  }

  void nextLocationAndWeather(Location location, Weather weather) {
    LatLng latlng = mapCoordinatesToLatLng(location.toCoordinates());

    if (!_isInitialSet) {
      setInitialPosition(location, latlng);
    } else if (isNavigating) {
      navigateTo(latlng);
    }
    _currentLocation = location;
    if (weather != null) {
      // if no new weather
      _currentWeather = weather;
    }

    refreshUI();
  }

  void setInitialPosition(Location location, LatLng latlng) {
    _isInitialSet = true;
    _initialPosition = location;
    _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(initial, 11));
    polylines.add(Polyline(
        polylineId: PolylineId('navigation'),
        color: Colors.green,
        width: 5,
        points: [latlng]));
  }

  void navigateTo(LatLng latlng) {
    // add more points to the the user's route
    polylines.elementAt(1).points.add(latlng);

    // update camera location
    _googleMapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: latlng, zoom: 18.5, tilt: 45)));
  }

  void locationTrackingStopped() {}

  void locationTrackingError(e) {}

  void googleMapsOnInit(Map params) {
    _googleMapController = params['controller'];
    print('Google maps initialized.');
  }

  @override
  void dispose() {
    _mapPresenter.dispose();
    super.dispose();
  }

  void pop() {
    Navigator.of(getContext(), rootNavigator: true).pop(); // dialog
    Navigator.of(getContext(), rootNavigator: true).pop(); //
  }

  void initPolylines() {
    polylines.add(Polyline(
        polylineId: PolylineId(polylines.length.toString()),
        points: mapCoordinatesListToLatLngList(_event.route),
        width: 5,
        color: Colors.red,
        patterns: [PatternItem.dot]));
  }

  void initMarkers() {
    _event.stops.forEach((stop) {
      markers.add(Marker(
        markerId: MarkerId(markers.length.toString()),
        position: mapCoordinatesToLatLng(stop),
        icon: stop == _event.hellsGate
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
            : BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
            title: stop == _event.hellsGate
                ? 'Hells Gate'
                : 'Rest Stop #${markers.length}'),
      ));
    });
  }
}
