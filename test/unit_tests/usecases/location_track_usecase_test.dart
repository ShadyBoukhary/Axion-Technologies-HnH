// Shady Boukhary

import 'package:location/location.dart' as lib;
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/usecases/location_track_usecase.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';
import 'package:logging/logging.dart';

void main() {
  group('LocationTrackUseCase', () {
    LocationTrackUseCase _locationTrackUseCase;
    _Observer observer;

    setUp(() {
    //  _locationTrackUseCase = LocationTrackUseCase(MockRepo());
      observer = _Observer();
      //initLogger();
    });

    // test('.execute() Retrieves location every 1 second.', () async {
    //   // subscribe
    //   _locationTrackUseCase.execute(observer);

    //   // stop observing after 2 locations were retrieved
    //   bool retrievedTwo = false;

    //   while (!retrievedTwo) {
    //     await Future.delayed(Duration(seconds: 1));
    //     if (observer.numberOfLocations > 2) {
    //       retrievedTwo = true;
    //     }
    //   }

    //   // unsubscribe and check whether any more locations are coming in
    //   _locationTrackUseCase.dispose();
    //   int locsNumBefore = observer.numberOfLocations;
    //   await Future.delayed(Duration(seconds: 1));
    //   expect(locsNumBefore, observer.numberOfLocations);
    // }); // end execute test
  }); // end group
} // end main

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    dynamic e = record.error;
    print(
        '${record.loggerName}: ${record.level.name}: ${record.message} ${e != null ? e?.message : ''}');
  });
  Logger.root.info("Logger initialized.");
}

class _Observer implements Observer<Location> {
  int numberOfLocations = 0;

  void onNext(location) {
    expect(location, TypeMatcher<Location>());
    numberOfLocations++;
  }

  void onComplete() {
    print("Complete");
  }

  void onError(e) {
    print(e);
  }
}

// class MockRepo extends Mock implements DeviceLocationRepository {
//   static Uuid uuid = Uuid();
//   @override
//   Future<Location> getLocation() async => Location(uuid.v4(), uuid.v4(), uuid.v4(), 5345234.0);
//   Observable<lib.Location> onLocationChanged() {
//     List<lib.Location> data = [lib.Location(), lib.Location()];
//     return Observable.fromIterable(data.map(((d) => d.)));
//   }
  //Future<Location> getLocation() async => throw Exception("Failed to get location.");
//}
