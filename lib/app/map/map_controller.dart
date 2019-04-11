import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/map/map_presenter.dart';
import 'package:hnh/data/repositories/data_directions_repository.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hnh/app/utils/google_maps_mapper.dart';

class MapController extends Controller {
  GoogleMapController _googleMapController;
  MapPresenter _mapPresenter;
  LatLng _initialPosition;
  bool _isInitialSet;
  Set<Polyline> polylines;
  Event _event;

  LatLng get initial => _initialPosition;

  MapController(locationRepository, this._event) {
    _mapPresenter = MapPresenter(locationRepository);
    _initialPosition = LatLng(33.911614, -98.496268);
    polylines = Set<Polyline>();
    _isInitialSet = false;
    initListeners();
    initPolylines();
    _mapPresenter.startTrackingLocation();
  }

  void initListeners() {
    _mapPresenter.locationOnNext = nextLocation;
    _mapPresenter.locationOnComplete = locationTrackingStopped;
    _mapPresenter.locationOnError = locationTrackingError;
  }

  void nextLocation(LatLng location) {
    if (!_isInitialSet) {
      _isInitialSet = true;
      _initialPosition = location;
    }
  }

  void locationTrackingStopped() {}

  void locationTrackingError(e) {}

  void googleMapsOnInit(Map params) {
    _googleMapController = params['controller'];
    print('Google maps initialized.');
  }

  void dispose() {
    _mapPresenter.dispose();
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
