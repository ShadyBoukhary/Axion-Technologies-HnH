// Shady Boukhary

import 'package:test/test.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'package:hnh/domain/entities/user.dart';

void main() {
  group('Entity Test: EventRegistration', () {
    Map<String, dynamic> eventRegistrationMap;
    EventRegistration testEventRegistration;
    Event testEvent;
    User testUser;
    setUp(() {
      var event = {
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
        ]
      };

      var user = {
        'firstName': 'John',
        'lastName': 'Smith',
        'uid': 'kjasdh8458y_43fadsfw43',
        'email': 'john_smith@unittest.com'
      };

      eventRegistrationMap = {
        'uid': user['uid'],
        'eventId': event['id'],
        'timestamp': '829375429835',
      };
      testUser = User('John', 'Smith', 'kjasdh8458y_43fadsfw43', 'john_smith@unittest.com');
      testEvent = Event('Event Lorem Ipsum', 'Lorem ipsum dolor sit amet.',
          Location('987523245', '985723982', '28753298357293'), '1234567890', false, [
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982')
      ]);
      testEventRegistration = EventRegistration('kjasdh8458y_43fadsfw43', '1234567890');
      eventRegistrationMap['timestamp'] = testEventRegistration.timestamp;
    }); // end setup

    test('.fromJson creates a correct EventRegistration', () {
      EventRegistration eventRegistration = EventRegistration.fromJson(eventRegistrationMap);
      expect(eventRegistration, TypeMatcher<EventRegistration>());
      expect(eventRegistration.timestamp, eventRegistrationMap['timestamp']);
      // test User
      expect(eventRegistration.uid, testUser.uid);
      // test Event
      expect(eventRegistration.eventId, testEvent.id);
    }); // end .fromJson test

    test('.toJson() returns a correct json.', () {
      Map<String, dynamic> eventRegistrationJson = testEventRegistration.toJson();
      expect(eventRegistrationJson, eventRegistrationMap);
    }); // end toJson test

    test('.fromEventRegistration() creates a correct EventRegistration', () {
      EventRegistration eventRegistration = EventRegistration.fromEventRegistration(testEventRegistration);
      expect(eventRegistration, predicate((eventRegistration) => eventRegistration != testEventRegistration));
      expect(eventRegistration.timestamp, testEventRegistration.timestamp);

      // test User
      expect(eventRegistration.uid, testEventRegistration.uid);

      // test Event
      expect(eventRegistration.eventId, testEventRegistration.eventId);
    }); // .fromEvent

  }); // end group
} // end main
