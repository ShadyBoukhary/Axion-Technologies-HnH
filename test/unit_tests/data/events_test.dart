// Shady Boukhary

import 'dart:async';
import 'package:test/test.dart';
import 'package:hnh/data/repositories/data_event_repository.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/event_registration.dart';
import 'package:hnh/domain/utils/utils.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';

void main() {
  group('DataEventsRepository', () {
    DataEventRepository dataEventRepository;
    EventRegistration eventRegistration;
    EventRegistration duplicate;
    EventRegistration sameUserDifferentEvent;
    EventRegistration differentUserSameEvent;
    EventRegistration realUserRealEvent;
    setUp(() {
      dataEventRepository = DataEventRepository();
      eventRegistration = EventRegistration(Utils.uuidRandom(), Utils.uuidRandom());
      
      duplicate = EventRegistration.fromEventRegistration(eventRegistration);
      sameUserDifferentEvent = EventRegistration(eventRegistration.uid, Utils.uuidRandom());
      differentUserSameEvent = EventRegistration(Utils.uuidRandom(), eventRegistration.eventId);
      realUserRealEvent = EventRegistration('5c56a23bd035c37032391053', '5c68d750cf2095b99753c693');
    });

    /// tests the getAllEvents method
    test('.getAllEvents()',  () async {
      expect(await dataEventRepository.getAllEvents(), TypeMatcher<List<Event>>());
    });

    test('.registerForEvent()', () async {

      // test regular event registration
      var result = dataEventRepository.registerForEvent(eventRegistration: eventRegistration);
      expect(result, TypeMatcher<Future<void>>());
      await result;

      // test same user registering for a different event
      expect(dataEventRepository.registerForEvent(eventRegistration: sameUserDifferentEvent), TypeMatcher<Future<void>>());

      // test different user registering for the same event as another user
      expect(dataEventRepository.registerForEvent(eventRegistration: differentUserSameEvent), TypeMatcher<Future<void>>());
      
       // test duplicate event registration
      expect(dataEventRepository.registerForEvent(eventRegistration: duplicate),
          throwsA(predicate((e) {
            expect(e, TypeMatcher<APIException>());
            var err = e as APIException;
            expect(err.statusCode, 400);
            expect(err.message, 'Already registered to event.');
            return true;
          }, 'Throws APIException with Already Registered message and 400.')));
    }); // end test

    test('.getUserEvents()', () async {
      try {
        await dataEventRepository.registerForEvent(eventRegistration: realUserRealEvent);
      } catch (error) {
        print(error.message);
      }
      
      List<Event> events = await dataEventRepository.getUserEvents(uid: '5c56a23bd035c37032391053');
      expect(events, TypeMatcher<List<Event>>());
      expect(events.length, greaterThan(0));
      expect(events.where((event) => event.id == realUserRealEvent.eventId), predicate((events) {
        expect(events.length, greaterThan(0));
        return true;
      }));
      await dataEventRepository.unRegisterFromEvent(eventRegistration: realUserRealEvent);
       // test non-existent user or user with no events registered
      events = await dataEventRepository.getUserEvents(uid: 'userDoesNotExistOrNoEvents');
      expect(events, TypeMatcher<List<Event>>());
      expect(events.length, 0);
          
    });

  }); // end group
} // end main
