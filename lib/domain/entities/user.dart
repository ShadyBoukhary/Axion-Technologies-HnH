/// A user of the application.
class User {

  /// The user's first name.
  final String firstName;

  /// The user's last name.
  final String lastName;

  /// The user's unique ID.
  final String uid;

  /// The user's email address.
  final String email;

  /// The user's initials in all caps.
  String get initials => '${firstName[0]}${lastName[0]}'.toUpperCase();

  /// The user's full name separated by a space.
  String get fullName => '$firstName $lastName';

  User(this.firstName, this.lastName, this.uid, this.email);

  User.fromUser(User user)
      : firstName = user.firstName,
        lastName = user.lastName,
        uid = user.uid,
        email = user.email;

  User.fromJson(Map<String, dynamic> map)
      : firstName = map['firstName'],
        lastName = map['lastName'],
        uid = map['uid'],
        email = map['email'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'uid': uid,
        'email': email
      };

  Map<String, String> toJson2() => {
        'firstName': firstName,
        'lastName': lastName,
        'uid': uid,
        'email': email
      };

  @override
  operator ==(dynamic user) => user is User && uid == user.uid;

  @override
  int get hashCode =>
      firstName.hashCode ^ lastName.hashCode ^ uid.hashCode ^ email.hashCode;
}
