import 'package:test/test.dart';
import 'package:hnh/data/repositories/hhh_repository.dart';
import 'package:hnh/domain/entities/hhh.dart';

void main() {
  group('DataHHHRepository', () {
    DataHHHRepository dataHHHRepository;

    setUp(() {
      dataHHHRepository = DataHHHRepository();
    });

    test('.getAllHHHs()',  () async {
      expect(await dataHHHRepository.getAllHHHs(), TypeMatcher<List<HHH>>());
    }); // end getAllHHHs test

    test('.getCurrentHHH()',  () async {
      String year = DateTime.now().year.toString();
      HHH hhh = await dataHHHRepository.getCurrentHHH();
      expect(hhh, TypeMatcher<HHH>());
      expect(hhh.id, year);
    }); // end getCurrentHHH test

  }); // end group
} // end main
