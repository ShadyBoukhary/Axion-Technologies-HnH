import 'dart:convert';
import 'package:hnh/domain/entities/coordinates.dart';

/// A local place, namely either a restaurant or a hotel as defined in [LocalPlaceType].
/// Used to indicate a restaurant of a hotel in town.
class LocalPlace {

  /// Name of the local place
  String _name;

  /// Address of the local place
  String _address;

  /// Location of the local place
  Coordinates _coordinates;

  /// Type of the local place
  LocalPlaceType _type;

  /// The average user rarting of the local place
  double _rating;

  /// The default icon, usually either a restaurant icon or a hotel icon
  String _icon;

  /// Link the local place's image
  String photo; // can be set later

  /// Indicates whether the local place is currently open. This is not always accurate
  /// depending on the information retrieved from Google
  bool _isOpen;

  /// Reference to the photo used to retrieve the link to the photo. This is not useful
  /// to the user.
  String _photoReference;

  /// Google Maps link to the local place. This can be used to open Google maps with a local place query. 
  String _navigationLink;

  /// Getters
  String get name => _name;
  String get address => _address;
  Coordinates get coordinates => _coordinates;
  LocalPlaceType get type => _type;
  String get typeString => _type == LocalPlaceType.restaurant ? 'restaurant' : 'hotel';
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

/// Indicates the types of local places available
enum LocalPlaceType { restaurant, hotel }
