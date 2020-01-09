import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/repositories/local_places_repository.dart';
import 'package:hnh/domain/repositories/location_repository.dart';

class GetLocalPlacesUseCase extends UseCase<List<LocalPlace>, void> {
  final LocalPlacesRepository _localPlacesRepository;
  final LocationRepository _locationRepository;
  GetLocalPlacesUseCase(this._localPlacesRepository, this._locationRepository);

  @override
  Future<Stream<List<LocalPlace>>> buildUseCaseStream(_) async {
    final StreamController<List<LocalPlace>> controller = StreamController();
    try {
      Location location = await _locationRepository.getLocation();
      Coordinates coordinates = Coordinates(location.lat, location.lon);
      List<LocalPlace> places =
          await _localPlacesRepository.getLocalRestaurants(latlon: coordinates);
      places.addAll(
          await _localPlacesRepository.getLocalHotels(latlon: coordinates));
      controller.add(places);
      logger.finest('GetLocalPlacesUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetLocalPlacesUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
