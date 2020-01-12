// Shady Boukhary

import 'package:test/test.dart';
import 'package:hnh/data/repositories/data_sponsor_repository.dart';
import 'package:hnh/domain/entities/sponsor.dart';
import 'package:hnh/domain/utils/utils.dart';

void main() {
  group('DataSponsorRepository', () {
    DataSponsorRepository dataSponsorRepository;
    String validYear = '2020';
    String currentYear = Utils.currentYear;
    String invalidYear = Utils.uuidRandom();

    setUp(() {
      dataSponsorRepository = DataSponsorRepository();
    });

    test('.getSponsors()',  () async {
    
      // test a valid year
      List<Sponsor> sponsors = await dataSponsorRepository.getSponsors(year: validYear);
      expect(sponsors, TypeMatcher<List<Sponsor>>());
      expect(sponsors.length, greaterThan(0));

      // test current year
      sponsors = await dataSponsorRepository.getSponsors(year: currentYear);
      expect(sponsors, TypeMatcher<List<Sponsor>>());
      expect(sponsors.length, greaterThan(0));

      // test a non-existent year
      sponsors = await dataSponsorRepository.getSponsors(year: invalidYear);
      expect(sponsors, TypeMatcher<List<Sponsor>>());
      expect(sponsors.length, 0);
    }); // end getSponsors test

    test('getCurrentSponsors()', () async {
      List<Sponsor> sponsors = await dataSponsorRepository.getCurrentSponsors();
      expect(sponsors, TypeMatcher<List<Sponsor>>());
      expect(sponsors.length, greaterThan(0));
    }); // end getCurrentSponsors
  }); // end group
} // end main
