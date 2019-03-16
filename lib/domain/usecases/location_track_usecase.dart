import 'package:hnh/domain/repositories/location_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// Tracks a user's [Location] every 1 second until the [UseCase] is disposed.
class LocationTrackUseCase extends UseCase<Location, void> {
  LocationRepository _locationRepository;
  LocationTrackUseCase(this._locationRepository) : super();

  @override
  Future<Observable<Location>> buildUseCaseObservable(void ignore) async {
    // Periodic observable every 1 second
    return Observable.periodic(Duration(seconds: 1), (second) {
      // get 1 location observable
      return Observable.fromFuture(getLocation());
    }).flatMap((mapper) => mapper)  // flatmap [[loc] [loc] [loc]] => [loc, loc, loc]
      .where((location) => location != null); // filter out null values if any
  }

  /// Retrieves current [location] from [_locat]
  Future<Location> getLocation() async {
    try {
      Location location = await _locationRepository.getLocation();
      logger.finest('Retrieved location successfully: $location');
      return location;
    } catch (e) {
      logger.warning('Could not update location while tracking.', e);
      rethrow;
    }
  }
}
