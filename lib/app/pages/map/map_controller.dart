import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/models/race_tracker.dart';
import 'package:hnh/app/pages/map/map_presenter.dart';
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
  double _totalDistance;
  double _remainingDistance;
  double _distanceTravelled;
  bool _isInitialSet;
  bool isNavigating;
  Set<Polyline> polylines;
  Set<Marker> markers;
  RaceTracker _event;

  LatLng get initial =>
      LatLng(_initialPosition.numLat, _initialPosition.numLon);
  Location get currentLocation => _currentLocation;
  Weather get currentWeather => _currentWeather;
  String get totalDistance => _totalDistance.toStringAsPrecision(2);
  String get remainingDistance => _remainingDistance.toStringAsPrecision(2);
  String get distanceTravelled => _distanceTravelled.toStringAsFixed(1);

  MapController(locationRepository, weatherRepository, Event event) {
    _event = RaceTracker.fromEvent(event);
    _mapPresenter = MapPresenter(locationRepository, weatherRepository);
    _currentLocation = _initialPosition = Location.wichitaFalls();
    _currentWeather = Weather.empty();
    _totalDistance = _remainingDistance = _distanceTravelled = 0;
    polylines = Set<Polyline>();
    markers = Set<Marker>();
    _isInitialSet = false;
    isNavigating = true;
    init();
    _mapPresenter.startTrackingLocation();
  }

  void init() {
    initListeners();
    initPolylines();
    initMarkers();
    // intialize distances
    if (_event.isRace) {
      _totalDistance = _event.calculateRouteDistance();
    } else {
      _totalDistance = 0;
      _remainingDistance = 0;
    }

    // set
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
    _remainingDistance = _event.advancePosition(location.toCoordinates());
    _distanceTravelled = 0.0242;//_event.distanceTravelled;
    double distanceToHG = _event.distanceToHellsGate(location.toCoordinates());
    if (_remainingDistance == 0) {
      // race completed
      // TODO: let the user know
    }
    refreshUI();
  }

  void setInitialPosition(Location location, LatLng latlng) {
    _isInitialSet = true;
    _initialPosition = location;
    _googleMapController?.animateCamera(CameraUpdate.newLatLngZoom(initial, 11));
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
    Navigator.of(getContext(), rootNavigator: true).pop(); // page
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
    if (_event.isRace) {
      // rest stop markers
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
      // start line
      markers.add(Marker(
        markerId: MarkerId(markers.length.toString()),
        position: mapCoordinatesToLatLng(_event.route.first),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
            title: 'Starting Line', snippet: 'This is where the race starts.'),
      ));

      // finish line
      markers.add(Marker(
        markerId: MarkerId(markers.length.toString()),
        position: mapCoordinatesToLatLng(_event.route.last),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
            title: 'Finish Line', snippet: 'This is where the race ends.'),
      ));
    }
  }
}
