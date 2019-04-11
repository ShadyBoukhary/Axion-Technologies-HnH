import 'package:hnh/app/abstract/controller.dart';
import 'package:hnh/app/map/map_presenter.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends Controller {
  GoogleMapController _googleMapController;
  MapPresenter _mapPresenter;
  LatLng _initialPosition;
  bool _isInitialSet;
  Event _event;

  LatLng get initial => _initialPosition;
  
  MapController(locationRepository, this._event) {
    _mapPresenter = MapPresenter(locationRepository);
    _initialPosition = LatLng(33.911614, -98.496268);
    _isInitialSet = false;
    initListeners();
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

  void locationTrackingStopped() {

  }

  void locationTrackingError(e) {

  }

  void googleMapsOnInit(Map params) {
    _googleMapController = params['controller'];
    print('Google maps initialized.');
  }
}
