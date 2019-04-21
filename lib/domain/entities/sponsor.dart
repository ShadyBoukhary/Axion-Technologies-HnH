// Shady Boukhary

/// An [HHH] sponser. Usually in the form of a business or organization.
class Sponsor {

  /// The name of the sponsor.
  final String name;

  /// The website of the sponsor.
  final String website;

  /// The official image of the sponsor.
  final String imageUrl;

  /// The year in which the sponsor sponsored the event. Can double as [HHH] ID.
  final String year;

  Sponsor(this.name, this.website, this.imageUrl, this.year);

  Sponsor.from(Sponsor sponsor)
      : name = sponsor.name,
        website = sponsor.website,
        imageUrl = sponsor.imageUrl,
        year = sponsor.year;

  Sponsor.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        website = map['website'],
        imageUrl = map['imageUrl'],
        year = map['year'];

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  Map<String, dynamic> toJson() =>
      {'name': name, 'website': website, 'imageUrl': imageUrl, 'year': year};

  /// Convert [this] to a Json `Map<String, String>`. All complex structures
  /// are also converted to `String`.
  Map<String, String> toJson2() => toJson().cast<String, String>();

  @override
  operator ==(dynamic sponsor) =>
      sponsor is Sponsor && website == sponsor.website;

  @override
  int get hashCode =>
      name.hashCode ^ website.hashCode ^ imageUrl.hashCode ^ year.hashCode;
}
