import 'package:hnh/domain/entities/weather.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/usecases/location_track_usecase.dart';

class MapPresenter {
  Function locationOnNext;
  Function locationOnComplete;
  Function locationOnError;

  LocationTrackUseCase _locationTrackUseCase;

  MapPresenter(locationRepository, weatherRepository) {
    _locationTrackUseCase = LocationTrackUseCase(locationRepository, weatherRepository);
  }

  void startTrackingLocation() => _locationTrackUseCase.execute(_LocationTrackObserver(this));

  void dispose() => _locationTrackUseCase.dispose();
}

class _LocationTrackObserver implements Observer<LocationTrackResponse> {
  MapPresenter _mapPresenter;
  _LocationTrackObserver(this._mapPresenter);

  void onNext(response) {
    assert(_mapPresenter.locationOnNext != null);
    _mapPresenter.locationOnNext(response.location, response.weather);
  }

  void onComplete() {
    assert(_mapPresenter.locationOnComplete != null);
    _mapPresenter.locationOnComplete();
  }

  void onError(e) {
    assert(_mapPresenter.locationOnError != null);
    print(e);
    _mapPresenter.locationOnError(e);
  }
}
