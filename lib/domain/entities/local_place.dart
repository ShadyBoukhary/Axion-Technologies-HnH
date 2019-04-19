import 'dart:convert';
import 'package:hnh/domain/entities/coordinates.dart';

class LocalPlace {
  String _name;
  String _address;
  Coordinates _coordinates;
  LocalPlaceType _type;
  double _rating;
  String _icon;
  String photo; // can be set later
  bool _isOpen;
  String _photoReference;
  String _navigationLink;

  String get name => _name;
  String get address => _address;
  Coordinates get coordinates => _coordinates;
  LocalPlaceType get type => _type;
  String get typeString =>
      _type == LocalPlaceType.restaurant ? 'restaurant' : 'hotel';
  double get rating => _rating;
  String get icon => _icon;
  bool get isOpen => _isOpen;
  String get photoReference => _photoReference;
  bool get hasPhotoReference => _photoReference != '404';
  String get navigationLink => _navigationLink;

  LocalPlace(
      this._name,
      this._address,
      this._type,
      this._coordinates,
      this._rating,
      this._icon,
      this.photo,
      this._isOpen,
      this._photoReference,
      this._navigationLink);

  LocalPlace.from(LocalPlace localPlace) {
    _name = localPlace._name;
    _address = localPlace._address;
    _coordinates = Coordinates.from(localPlace._coordinates);
    _type = localPlace._type;
    _rating = localPlace._rating;
    _icon = localPlace._icon;
    photo = localPlace.photo;
    _isOpen = localPlace._isOpen;
    _photoReference = localPlace._photoReference;
    _navigationLink = localPlace._navigationLink;
  }

  LocalPlace.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _address = map['address'];
    _coordinates = map['coordinates'] as Coordinates;
    _type = map['type'];
    _rating = double.parse(map['rating']);
    _icon = map['icon'];
    photo = map['photo'];
    _isOpen = map['isOpen'];
    _photoReference = map['photoReference'];
    _navigationLink = map['navigationLink'];
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'address': _address,
        'coordinates': _coordinates.toJson(),
        'type': _type,
        'rating': _rating,
        'icon': _icon,
        'photo': photo,
        'isOpen': _isOpen,
        'photoReference': _photoReference,
        'navigationLink': _navigationLink
      };

  Map<String, String> toJson2() => {
        'name': _name,
        'address': _address,
        'coordinates': jsonEncode(_coordinates),
        'type': jsonEncode(_type),
        'rating': jsonEncode(_rating),
        'icon': _icon,
        'photo': photo,
        'isOpen': jsonEncode(_isOpen),
        'photoReference': _photoReference,
        'navigationLink': _navigationLink
      };

  @override
  operator ==(dynamic localPlace) =>
      localPlace is LocalPlace && _name == localPlace._name;

  @override
  int get hashCode =>
      _name.hashCode ^ _address.hashCode ^ _type.hashCode ^ _rating.hashCode;
}

enum LocalPlaceType { restaurant, hotel }
