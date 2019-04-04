import 'dart:convert';
import 'package:hnh/domain/entities/coordinates.dart';

class LocalPlace {
  String _name;
  String _address;
  Coordinates _coordinates;
  LocalPlaceType _type;
  double _rating;
  String _icon;
  String _photo;
  bool _isOpen;

  String get name => _name;
  String get address => _address;
  Coordinates get coordinates => _coordinates;
  LocalPlaceType get type => _type;
  String get typeString => _type == LocalPlaceType.restaurant ? 'restaurant' : 'hotel';
  double get rating => _rating;
  String get icon => _icon;
  String get photo => _photo;
  bool get isOpen => _isOpen;

  LocalPlace(this._name, this._address, this._type, this._coordinates, this._rating, this._icon, this._photo, this._isOpen);

  LocalPlace.from(LocalPlace localPlace) {
    _name = localPlace._name;
    _address = localPlace._address;
    _coordinates = Coordinates.from(localPlace._coordinates);
    _type = localPlace._type;
    _rating = localPlace._rating;
    _icon = localPlace._icon;
    _photo = localPlace._photo;
    _isOpen = localPlace._isOpen;
  }

  LocalPlace.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _address = map['address'];
    _coordinates = map['coordinates'] as Coordinates;
    _type = map['type'];
    _rating = double.parse(map['rating']);
    _icon = map['icon'];
    _photo = map['photo'];
    _isOpen = map['isOpen'];
  }

  Map<String, dynamic> toJson() =>
    {
      'name': _name,
      'address': _address,
      'coordinates': _coordinates.toJson(),
      'type': _type,
      'rating': _rating,
      'icon': _icon,
      'photo': _photo,
      'isOpen': _isOpen
    };

  Map<String, String> toJson2() =>
    {
      'name': _name,
      'address': _address,
      'coordinates': jsonEncode(_coordinates),
      'type': jsonEncode(_type),
      'rating': jsonEncode(_rating),
      'icon': _icon,
      'photo': _photo,
      'isOpen': jsonEncode(_isOpen)
    };

    @override
    operator ==(dynamic localPlace) => localPlace is LocalPlace && _name == localPlace._name;

    @override
    int get hashCode => _name.hashCode ^ _address.hashCode ^ _type.hashCode ^ _rating.hashCode;
}

enum LocalPlaceType {
  restaurant,
  hotel
}