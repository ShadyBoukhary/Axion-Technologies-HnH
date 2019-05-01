// Shady Boukhary

import 'package:test/test.dart';
import 'package:hnh/domain/entities/sponsor.dart';

void main() {
  group('Entity Test: Sponsor', () {
    Map<String, String> testSponsorMap;
    Sponsor testSponsor;
    setUp(() {
        testSponsor = Sponsor("lorem Ipsum", 'www.lorem-ipsum.com', 'https://lorem-ipsum.com/image', '2019');
        testSponsorMap = {
          'name':testSponsor.name,
          'website': testSponsor.website,
          'imageUrl': testSponsor.imageUrl,
          'year': testSponsor.year
        };
    });
 
    test('.fromJson(map) creates a Sponsor correctly.', () {
      Sponsor sponsor = Sponsor.fromJson(testSponsorMap);
      expect(sponsor, TypeMatcher<Sponsor>());
      expect(sponsor.name, testSponsor.name);
      expect(sponsor.website, testSponsor.website);
      expect(sponsor.imageUrl, testSponsor.imageUrl);
      expect(sponsor.year, testSponsor.year);
    }); // end .fromJson test

    test('.toJson() returns a correct json.', () {
      Map<String, dynamic> sponsor = testSponsor.toJson();
      expect(sponsor, testSponsorMap);
    }); // end .toJson()

    test('.toJson2() returns a correct json.', () {
      Map<String, String> sponsor = testSponsor.toJson2();
      expect(sponsor, testSponsorMap);
    }); // end .toJson2()

    test('.from() creates a correct Sponsor', () {
      Sponsor sponsor = Sponsor.from(testSponsor);
      expect(sponsor, predicate((sponsor) => !identical(sponsor, testSponsor)));
      expect(sponsor.name, testSponsor.name);
      expect(sponsor.website, testSponsor.website);
      expect(sponsor.imageUrl, testSponsor.imageUrl);
      expect(sponsor.year, testSponsor.year);
    }); // .fromEvent
  }); // end group
} // end main
