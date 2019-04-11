import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/usecases/location_track_usecase.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPresenter {
  Function locationOnNext;
  Function locationOnComplete;
  Function locationOnError;

  LocationTrackUseCase _locationTrackUseCase;

  MapPresenter(locationRepository) {
    _locationTrackUseCase = LocationTrackUseCase(locationRepository);
  }

  void startTrackingLocation() => _locationTrackUseCase.execute(_LocationTrackObserver(this));

  void dispose() => _locationTrackUseCase.dispose();
}

class _LocationTrackObserver implements Observer<Location> {
  MapPresenter _mapPresenter;
  _LocationTrackObserver(this._mapPresenter);

  void onNext(location) {
    assert(_mapPresenter.locationOnNext != null);
    LatLng latLng = LatLng(location.numLat, location.numLon);
    _mapPresenter.locationOnNext(latLng);
  }

  void onComplete() {
    assert(_mapPresenter.locationOnComplete != null);
    _mapPresenter.locationOnComplete();
  }

  void onError(e) {
    assert(_mapPresenter.locationOnError != null);
    _mapPresenter.locationOnError(e);
  }
}
