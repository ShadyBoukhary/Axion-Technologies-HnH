// Shady Boukhary

import 'dart:async';
import 'package:test/test.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';

void main() {
  group('DataAuthenticationRepository', () {
    DataAuthenticationRepository dataAuthenticationRepository;

    setUp(() {
      dataAuthenticationRepository = DataAuthenticationRepository();
    });

    /// tests the authenicate method
    test('.authenticate() logs user in correctly and handles errors.', () async {

      // test correct login
      expect(dataAuthenticationRepository.authenticate(email: 'test@test.com', password: '123456'),TypeMatcher<Future<void>>());

      //test user not found
      expect(dataAuthenticationRepository.authenticate(email: 'usernotfound@test.com', password: 'invalidpassword'),
          throwsA(predicate((e) {
            expect(e, TypeMatcher<APIException>());
            var err = e as APIException;
            expect(err.statusCode, 400);
            expect(err.message, 'No user with this email is registered in our system.');
            return true;
          }, 'Throws APIException with User not found message and 400.')));

      // test wrong password
      expect(dataAuthenticationRepository.authenticate(email: 'test@test.com', password: 'invalidpassword'),
          throwsA(predicate((e) {
            expect(e, TypeMatcher<APIException>());
            var err = e as APIException;
            expect(err.statusCode, 400);
            expect(err.message, 'The password provided is incorrect.');
            return true;
          }, 'Throws APIException with Wrong password message and 400.')));
    }); // end test


  }); // end group
} // end main
