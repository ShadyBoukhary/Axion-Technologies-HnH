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
        'user': user,
        'event': event,
        'registrationTime': '829375429835',
        'id': 'replace'
      };
      testUser = User('John', 'Smith', 'kjasdh8458y_43fadsfw43', 'john_smith@unittest.com');
      testEvent = Event('Event Lorem Ipsum', 'Lorem ipsum dolor sit amet.',
          Location('987523245', '985723982', '28753298357293'), '1234567890', [
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982'),
        Coordinates('987523245', '985723982')
      ]);
      testEventRegistration = EventRegistration(testUser, testEvent);
      eventRegistrationMap['registrationTime'] = testEventRegistration.registrationTime;
      eventRegistrationMap['id'] = testEventRegistration.id;
    }); // end setup

    test('.fromJson creates a correct EventRegistration', () {
      EventRegistration eventRegistration = EventRegistration.fromJson(eventRegistrationMap);
      expect(eventRegistration, TypeMatcher<EventRegistration>());
      expect(eventRegistration.id, testEventRegistration.id);
      // test User
      expect(eventRegistration.user.firstName, testUser.firstName);
      expect(eventRegistration.user.lastName, testUser.lastName);
      expect(eventRegistration.user.uid, testUser.uid);
      expect(eventRegistration.user.email, testUser.email);

      // test Event
      expect(eventRegistration.event.name, testEvent.name);
      expect(eventRegistration.event.description, testEvent.description);
      expect(eventRegistration.event.location.lat, testEvent.location.lat);
      expect(eventRegistration.event.location.lon, testEvent.location.lon);
      expect(eventRegistration.event.id, testEvent.id);
      expect(eventRegistration.event.route.length, testEvent.route.length);
    }); // end .fromJson test

    test('.toJson() returns a correct json.', () {
      Map<String, dynamic> eventRegistrationJson = testEventRegistration.toJson();
      expect(eventRegistrationJson, eventRegistrationMap);
    }); // end toJson test

    test('.fromEventRegistration() creates a correct EventRegistration', () {
      EventRegistration eventRegistration = EventRegistration.fromEventRegistration(testEventRegistration);
      expect(eventRegistration, predicate((eventRegistration) => eventRegistration != testEventRegistration));
      expect(eventRegistration.registrationTime, testEventRegistration.registrationTime);

      // test User
      expect(eventRegistration.user.firstName, testEventRegistration.user.firstName);
      expect(eventRegistration.user.lastName, testEventRegistration.user.lastName);
      expect(eventRegistration.user.uid, testEventRegistration.user.uid);
      expect(eventRegistration.user.email, testEventRegistration.user.email);

      // test Event
      expect(eventRegistration.event.name, testEventRegistration.event.name);
      expect(eventRegistration.event.description, testEventRegistration.event.description);
      expect(eventRegistration.event.location.lat, testEventRegistration.event.location.lat);
      expect(eventRegistration.event.location.lon, testEventRegistration.event.location.lon);
      expect(eventRegistration.event.id, testEventRegistration.event.id);
      expect(eventRegistration.event.route.length, testEventRegistration.event.route.length);
    }); // .fromEvent

  }); // end group
} // end main
