class User {
  String _firstName;
  String _lastName;
  String _uid;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get uid => _uid;

  User(this._firstName, this._lastName, this._uid);
  
  User.fromUser(User user) {
    _firstName = user.firstName;
    _lastName = user.lastName;
    _uid = user._uid;
  }
}