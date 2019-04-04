// Shady Boukhary

import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/local_place.dart';
import 'package:test/test.dart';
import 'package:hnh/data/repositories/data_local_places_repository.dart';

void main() {
  group('DataLocalPlacesRepository', () {
    DataLocalPlacesRepository dataLocalPlacesRepository;
    Coordinates location;
    setUp(() {
      dataLocalPlacesRepository = DataLocalPlacesRepository();
      location = Coordinates('33.909760', '-98.500847');
    });

    // test('getLocalRestaurants()', () async {
    //   List<LocalPlace> localPlaces = await dataLocalPlacesRepository.getLocalRestaurants(latlon: location);
    //   expect(localPlaces, TypeMatcher<List<LocalPlace>>());
    //   localPlaces.forEach((place) {
    //     expect(place.type, LocalPlaceType.restaurant);
    //   });
    // }); // end getLocalRestaurants
  }); // end group
} // end main
