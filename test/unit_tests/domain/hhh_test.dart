import 'package:test/test.dart';
import 'package:hnh/domain/entities/hhh.dart';
import 'dart:convert';

void main() {
  group('Entity Test: HHH', () {
    Map<String, dynamic> hhhMap;
    Map<String, String> hhhJson;
    HHH testHHH;

    setUp(() {
      hhhMap = {
        'id': '2019',
        'description': '2019 HHH 100 Event Test',
        'mailingAddress': '5th Street, Come City, State, USA',
        'timestamp': '3287428374',
        'sponsors': ['fhs7fhsd87fsd87', 'ds87f89s7fsdf', '76fsdy6sdf8sfd'],
        'events': ['8f7s8d8sf', '897f987sd8f7wf', 'fsdhfsdyf87']
      };

      hhhJson = {
        'id': '2019',
        'description': '2019 HHH 100 Event Test',
        'mailingAddress': '5th Street, Come City, State, USA',
        'timestamp': '3287428374',
        'sponsors': jsonEncode(hhhMap['sponsors']),
        'events': jsonEncode(hhhMap['events'])
      };

      testHHH = HHH(
          '2019',
          '2019 HHH 100 Event Test',
          '5th Street, Come City, State, USA',
          '3287428374',
          ['fhs7fhsd87fsd87', 'ds87f89s7fsdf', '76fsdy6sdf8sfd'],
          ['8f7s8d8sf', '897f987sd8f7wf', 'fsdhfsdyf87']);
    });

    test('.fromJson(map) creates an HHH correctly.', () {
      HHH hhh = HHH.fromJson(hhhMap);
      expect(hhh.id, testHHH.id);
      expect(hhh.description, testHHH.description);
      expect(hhh.mailingAddress, testHHH.mailingAddress);
      expect(hhh.timestamp, testHHH.timestamp);
      expect(hhh.sponsors, testHHH.sponsors);
      expect(hhh.events, testHHH.events);
    }); // end fromJson test

    test('.toJson() creates a correct map', () {
      Map<String, dynamic> hhhMap2 = testHHH.toJson();
      expect(hhhMap2, hhhMap);
    });

    test('toJson2() creates correct json', () {
      Map<String, String> hhhJson2 = testHHH.toJson2();
      expect(hhhJson2, hhhJson);
      expect(jsonDecode(hhhJson2['sponsors']), testHHH.sponsors);
      expect(jsonDecode(hhhJson2['events']), testHHH.events);
    });

    test('.addSponsors() adds sponsors correctly.', () {
      HHH hhh = HHH(
          testHHH.id,
          testHHH.description,
          testHHH.mailingAddress,
          testHHH.timestamp,
          List.from(testHHH.sponsors),
          List.from(testHHH.events));
      hhh.addSponsors(['824537298735', '2434234234']);
      expect(hhh.sponsors.length, greaterThan(testHHH.sponsors.length));
      expect(hhh.sponsors[3], '824537298735');
      expect(hhh.sponsors[4], '2434234234');
    });

    test('.addEvents() adds events correctly.', () {
      HHH hhh = HHH(
          testHHH.id,
          testHHH.description,
          testHHH.mailingAddress,
          testHHH.timestamp,
          List.from(testHHH.sponsors),
          List.from(testHHH.events));
      hhh.addEvents(['2342342352435', '234823498234dsa']);
      expect(hhh.events.length, greaterThan(testHHH.events.length));
      expect(hhh.events[3], '2342342352435');
      expect(hhh.events[4], '234823498234dsa');
    });
    test('.fromHHH() creates HHH correctly', () {
      HHH hhh = HHH.fromHHH(testHHH);
      expect(hhh.id, testHHH.id);
      expect(hhh.description, testHHH.description);
      expect(hhh.mailingAddress, testHHH.mailingAddress);
      expect(hhh.timestamp, testHHH.timestamp);
      expect(hhh.sponsors, testHHH.sponsors);
      expect(hhh.events, testHHH.events);
    });
  }); // end group
} // end main
