import 'package:flutter/widgets.dart';
import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/map/map_presenter.dart';
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
  Set<Polyline> polylines;
  Event _event;

  LatLng get initial => LatLng(_initialPosition.numLat, _initialPosition.numLon);
  Location get currentLocation => _currentLocation;
  Weather get currentWeather => _currentWeather;

  MapController(locationRepository, weatherRepository, this._event) {
    _mapPresenter = MapPresenter(locationRepository, weatherRepository);
    _currentLocation = _initialPosition = Location('33.911614', '-98.496268', '0', 1);
    _currentWeather = Weather.empty();
    polylines = Set<Polyline>();
    _isInitialSet = false;
    initListeners();
    initPolylines();
    _mapPresenter.startTrackingLocation();
  }

  void initListeners() {
    _mapPresenter.locationOnNext = nextLocationAndWeather;
    _mapPresenter.locationOnComplete = locationTrackingStopped;
    _mapPresenter.locationOnError = locationTrackingError;
  }

  void nextLocationAndWeather(Location location, Weather weather) {
    if (!_isInitialSet) {
      _isInitialSet = true;
      _initialPosition = location;
      _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(initial, 11));
    }
    _currentLocation = location;
    if (weather != null) {
      // if no new weather
      _currentWeather = weather;
    }
    refreshUI();
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
    //   for (var coordinate in _event.route) {
    polylines.add(Polyline(
        polylineId: PolylineId(polylines.length.toString()),
        points: mapCoordinatesListToLatLngList(_event.route),
        width: 5));
    //  polylines.add(Polyline(polylineId: PolylineId(polylines.length.toString()),points: [mapCoordinatesToLatLng(coordinate)], width: 50));
//    }
  }
}
