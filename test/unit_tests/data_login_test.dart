import 'package:test/test.dart';
import 'package:hnh/data/repositories/data_authentication_repository.dart';
import 'package:hnh/data/utils/constants.dart';
import 'package:hnh/data/exceptions/authentication_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('DataAuthenticationRepository', () {
    DataAuthenticationRepository dataAuthenticationRepository;

    setUp(() {
      dataAuthenticationRepository = DataAuthenticationRepository();
    });

    /// tests the authenicate method
    test('.authenticate() logs user in correctly and handles errors.', () async {

      // test correct login
      expect(dataAuthenticationRepository.authenticate(email: 'test@test.com', password: 'shady'),TypeMatcher<Future<void>>());

      // test user not found
      expect(dataAuthenticationRepository.authenticate(email: 'usernotfound@test.com', password: 'invalidpassword'),
          throwsA(predicate((e) {
            expect(e, TypeMatcher<APIException>());
            var err = e as APIException;
            expect(err.statusCode, 400);
            expect(err.message, 'User not found.');
            return true;
          }, 'Throws APIException with User not found message and 400.')));

      // test wrong password
      expect(dataAuthenticationRepository.authenticate(email: 'test@test.com', password: 'invalidpassword'),
          throwsA(predicate((e) {
            expect(e, TypeMatcher<APIException>());
            var err = e as APIException;
            expect(err.statusCode, 400);
            expect(err.message, 'Wrong password.');
            return true;
          }, 'Throws APIException with Wrong password message and 400.')));
    }); // end test


  }); // end group
} // end main
