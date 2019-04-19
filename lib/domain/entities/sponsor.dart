// Shady Boukhary

class Sponsor {
  // Members
  String _name;
  String _website;
  String _imageUrl;
  String _year;

  // Properties
  String get name => _name;
  String get website => _website;
  String get imageUrl => _imageUrl;
  String get year => _year;

  // Constructors

  Sponsor(this._name, this._website, this._imageUrl, this._year);

  Sponsor.from(Sponsor sponsor) {
    _name = sponsor._name;
    _website = sponsor._website;
    _imageUrl = sponsor._imageUrl;
    _year = sponsor._year;
  }

  Sponsor.fromJson(Map<String, dynamic> map) {
    _name = map['name'];
    _website = map['website'];
    _imageUrl = map['imageUrl'];
    _year = map['year'];
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'website': _website,
        'imageUrl': _imageUrl,
        'year': _year
      };

  Map<String, String> toJson2() => toJson().cast<String, String>();

  @override
  operator ==(dynamic sponsor) =>
      sponsor is Sponsor && _website == sponsor._website;

  @override
  int get hashCode =>
      _name.hashCode ^ _website.hashCode ^ _imageUrl.hashCode ^ _year.hashCode;
}
