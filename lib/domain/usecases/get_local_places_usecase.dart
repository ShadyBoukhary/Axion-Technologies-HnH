import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/repositories/local_places_repository.dart';
import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class GetLocalPlacesUseCase extends UseCase<List<LocalPlace>, GetLocalPlacesUseCaseParams> {
  LocalPlacesRepository _localPlacesRepository;
  GetLocalPlacesUseCase(this._localPlacesRepository);

  @override
  Future<Observable<List<LocalPlace>>> buildUseCaseObservable(GetLocalPlacesUseCaseParams params) async {
    final StreamController<List<LocalPlace>> controller = StreamController();
    try {
      Coordinates coordinates = Coordinates(params._lat, params._lon);
      List<LocalPlace> places = await _localPlacesRepository.getLocalRestaurants(latlon: coordinates);
      controller.add(places);
      logger.finest('GetLocalPlacesUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetLocalPlacesUseCase unsuccessful.');
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

class GetLocalPlacesUseCaseParams {
  final String _lat;
  final String _lon;
  GetLocalPlacesUseCaseParams(this._lat, this._lon);
}


