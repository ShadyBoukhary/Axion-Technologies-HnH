import 'package:test/test.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:hnh/domain/entities/event.dart';
void main() {
  group('DataEventsRepository', () {
    DataEventRepository dataEventRepository;

    setUp(() {
      dataEventRepository = DataEventRepository();
    });

    /// tests the getAllEvents method
    test('.getAllEvents()',  () async {
      expect(await dataEventRepository.getAllEvents(), TypeMatcher<List<Event>>());
    });


  }); // end group
} // end main
