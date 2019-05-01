import 'package:hnh/domain/usecases/usecase.dart';
import 'package:hnh/domain/entities/sponsor.dart';
import 'package:hnh/domain/repositories/sponsor_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

/// Retrieves this year's [Sponsor]s
class GetSponsorsUseCase extends UseCase<GetSponsorsUseCaseResponse, void> {
  SponsorRepository _sponsorRepository;

  GetSponsorsUseCase(this._sponsorRepository);

  @override
  Future<Observable<GetSponsorsUseCaseResponse>> buildUseCaseObservable(_) async {
    final StreamController<GetSponsorsUseCaseResponse> controller = StreamController();
    try {
      // get current HHH and Sponsors in parallel
      List<Sponsor> sponsors = await _sponsorRepository.getCurrentSponsors();

      GetSponsorsUseCaseResponse response = GetSponsorsUseCaseResponse(sponsors);
      controller.add(response);
      logger.finest('GetSponsorsUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetSponsorsUseCase unsuccessful.');
      controller.addError(e);
    }
    return Observable(controller.stream);
  }
}

class GetSponsorsUseCaseResponse {
  List<Sponsor> _sponsors;
  List<Sponsor> get sponsors => _sponsors;
  GetSponsorsUseCaseResponse(this._sponsors);
}


