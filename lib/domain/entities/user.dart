class User {
  String _firstName;
  String _lastName;
  String _email;
  String _uid;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get uid => _uid;
  String get email => _email;

  User(this._firstName, this._lastName, this._uid, this._email);
  
  User.fromUser(User user) {
    _firstName = user.firstName;
    _lastName = user.lastName;
    _uid = user._uid;
    _email = user._email;
  }
}