// Shady Boukhary

import 'dart:convert';

/// Represents the yearly HHH general event. Contains a list of [events] and a list of [sponsors].
/// The [id] of the [HHH] is the year. Eg. `id = 2019`.
class HHH {
  /// The unique ID of [HHH]. The ID is in the form of the year in which the HHH is held.
  final String id; // year

  /// The description of [HHH] events. Taken from the website.
  final String description;

  /// The mailing address provided for any inqueries.
  final String mailingAddress;

  /// The start date of the [HHH] yearly event.
  final String timestamp;

  /// A list of this [HHH] `Sponsor` ID's.
  final List<String> sponsors;

  /// A list of this [HHH] `Event` ID's.
  final List<String> events;

  /// Start time of the [HHH] in the form of [DateTime].
  DateTime get eventTime =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

  // Constructors
  HHH(this.id, this.description, this.mailingAddress, this.timestamp,
      this.sponsors, this.events);

  /// From a [map]
  HHH.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        description = map['description'],
        mailingAddress = map['mailingAddress'],
        timestamp = map['timestamp'],
        sponsors = map['sponsors'].cast<String>().toList(),
        events = map['events'].cast<String>().toList();

  /// From an [hhh]
  HHH.fromHHH(HHH hhh)
      : id = hhh.id,
        description = hhh.description,
        mailingAddress = hhh.mailingAddress,
        timestamp = hhh.timestamp,
        sponsors = List.from(hhh.sponsors),
        events = List.from(hhh.events);

  /// To a nested `Map`
  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'mailingAddress': mailingAddress,
        'timestamp': timestamp,
        'sponsors': sponsors,
        'events': events
      };

  /// To a `string` `map`
  Map<String, String> toJson2() => {
        'id': id,
        'description': description,
        'mailingAddress': mailingAddress,
        'timestamp': timestamp,
        'sponsors': jsonEncode(sponsors),
        'events': jsonEncode(events)
      };

  /// Adds a list of [eventIds] to [events]
  void addEvents(List<String> eventIds) {
    events.addAll(eventIds);
  }

  /// Adds a list of [sponsorIds] to [sponsors]
  void addSponsors(List<String> sponsorIds) {
    sponsors.addAll(sponsorIds);
  }
}
