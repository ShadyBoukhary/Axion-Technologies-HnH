// Shady Boukhary

import 'package:test/test.dart';
import 'package:hnh/domain/usecases/get_hhh_usecase.dart';
import 'package:hnh/domain/usecases/observer.dart';
import 'package:hnh/domain/repositories/hhh_repository.dart';
import 'package:hnh/domain/repositories/sponsor_repository.dart';
import 'package:hnh/domain/entities/hhh.dart';
import 'package:hnh/domain/entities/sponsor.dart';
import 'package:mockito/mockito.dart';
import 'package:logging/logging.dart';

void main() {
  group('LocationTrackUseCase', () {
    GetHHHUseCase _getHHHUseCase;
    _Observer observer;

    setUp(() {
      _getHHHUseCase = GetHHHUseCase(MockHHHRepo(), MockSponsorRepo());
      observer = _Observer();
      //initLogger();
    });

    test('.execute() Retrieves current HHH and its Sponsors', () async {
      _getHHHUseCase.execute(observer);
      while (!observer.done) {
        await Future.delayed(Duration(seconds: 1));
      }
      _getHHHUseCase.dispose();
    }); // end execute test
  }); // end group
} // end main

// ------------------------------------------------------------------------------

void initLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    dynamic e = record.error;
    print(
        '${record.loggerName}: ${record.level.name}: ${record.message} ${e != null ? e?.message : ''}');
  });
  Logger.root.info("Logger initialized.");
}

/// Observer to execute [UseCase] with
class _Observer implements Observer<GetHHHUseCaseResponse> {

  bool done = false;
  void onNext(response) {
    expect(response, TypeMatcher<GetHHHUseCaseResponse>());
    expect((response as GetHHHUseCaseResponse).hhh, TypeMatcher<HHH>());
    expect((response as GetHHHUseCaseResponse).sponsors, TypeMatcher<List<Sponsor>>());
    done = true;
  }

  void onComplete() {
    print("Complete");
  }

  void onError(e) {
    print(e);
    throw e;
  }
}

/// Mocks [HHHRepository]
class MockHHHRepo extends Mock implements HHHRepository {
  HHH testHHH;

  MockHHHRepo() {
    testHHH = HHH(
        '2019',
        '2019 HHH 100 Event Test',
        '5th Street, Come City, State, USA',
        '3287428374',
        ['fhs7fhsd87fsd87', 'ds87f89s7fsdf', '76fsdy6sdf8sfd'],
        ['8f7s8d8sf', '897f987sd8f7wf', 'fsdhfsdyf87']);
  }

  Future<List<HHH>> getAllHHHs() async => [testHHH, testHHH, testHHH];
  Future<HHH> getCurrentHHH() async => testHHH;
}

/// Mocks [SponsorRepository]
class MockSponsorRepo extends Mock implements SponsorRepository {
  Sponsor testSponsor;

  MockSponsorRepo() {
    testSponsor = Sponsor("lorem Ipsum", 'www.lorem-ipsum.com', 'https://lorem-ipsum.com/image', '2019');
  }

  Future<List<Sponsor>> getSponsors({String year}) async => [testSponsor, testSponsor, testSponsor];
  Future<List<Sponsor>> getCurrentSponsors() => getSponsors();
}
