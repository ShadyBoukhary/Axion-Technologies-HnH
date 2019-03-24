// Shady Boukhary

import 'package:test/test.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/location.dart';

void main() {
  group('Entity Test: Event', () {
    Map<String, dynamic> eventMap;
    Event testEvent;

    setUp(() {
      eventMap = {
        'name': 'Event Lorem Ipsum',
        'description': 'Lorem ipsum dolor sit amet.',
        'location': {
          'lat': '987523245',
          'lon': '985723982',
          'timestamp': '28753298357293'
        },
        'id': '1234567890',
        'route': [
          {
            'lat': '987523245',
            'lon': '985723982',
          },
          {
            'lat': '987523245',
            'lon': '985723982',
          },
          {
            'lat': '987523245',
            'lon': '985723982',
          },
          {
            'lat': '987523245',
            'lon': '985723982',
          },
        ],
        'imageUrl': 'https://something.com/sme/image'
      };

      testEvent = Event('Event Lorem Ipsum', 'Lorem ipsum dolor sit amet.',
          Location('987523245', '985723982', '28753298357293'), '1234567890', false, [
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982')
      ], 'https://something.com/sme/image');
    });

    test('.fromMap(map) creates an Event correctly.', () {
      Event event = Event.fromJson(eventMap);
      expect(event, TypeMatcher<Event>());
      expect(event.name, 'Event Lorem Ipsum');
      expect(event.description, 'Lorem ipsum dolor sit amet.');
      expect(event.location.lat, '987523245');
      expect(event.location.lon, '985723982');
      expect(event.location.timestamp, '28753298357293');
      expect(event.id, '1234567890');
      expect(event.route.length, 4);
      event.route.forEach((coords) {
        expect(coords, TypeMatcher<Coordinates>());
      });
    }); // end .fromMap test

    test('.toMap() returns a correct json.', () {
      Map<String, dynamic> event = testEvent.toJson();
      expect(event, eventMap);
    }); // end .toMap()

    test('.fromEvent() creates a correct Event', () {
      Event event = Event.fromEvent(testEvent);
      expect(event, predicate((event) => event != testEvent));
      expect(event.name, testEvent.name);
      expect(event.description, testEvent.description);
      expect(event.location.lat, testEvent.location.lat);
      expect(event.location.lon, testEvent.location.lon);
      expect(event.id, testEvent.id);
      expect(event.route.length, testEvent.route.length);
    }); // .fromEvent
  }); // end group
} // end main
