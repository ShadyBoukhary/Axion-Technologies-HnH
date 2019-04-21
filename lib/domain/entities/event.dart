// Shady Boukhary

import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'dart:convert';

/// An HHH event. The event could either be a regular event of a race, in which case
/// it has more functionality.
class Event {
  /// The official name of the event.
  final String name;

  /// The description of the event. This can be multi-line and include information
  /// such as start and end dates - as well as price for entry.
  final String description;

  /// The location at which the event will be held. This also includes the start time.
  final Location location;

  /// The unique ID of the event.
  final String id;

  /// The route of the event. Empty if not a race.
  final List<Coordinates> route;

  /// The rest stops of the event. Empty if not a race.
  final List<Coordinates> stops;

  /// The link to the image of the event.
  final String imageUrl;

  /// Whether the event should be a part of the `featured` events.
  final bool isFeatured;

  /// [Coordinates] of the `Hell's Gate` rest stop.
  Coordinates get hellsGate => stops != null ? stops[0] : Coordinates('', '');

  /// [Coordinates] of the finish line.
  Coordinates get finishLine => stops != null ? stops[1] : Coordinates('', '');

  /// [Coordinates] of the medical rest stop.
  Coordinates get medicalStop => stops != null ? stops[2] : Coordinates('', '');

  /// Event time in Unix-time stamp in `milliseconds`
  DateTime get eventTime =>
      DateTime.fromMillisecondsSinceEpoch(int.parse(location.timestamp) * 1000);

  /// Whether the [Event] is a race.
  bool get isRace => route.length > 0;


  // Default
  Event(this.name, this.description, this.location, this.id,
      [this.isFeatured, this.route, this.imageUrl, this.stops]);

  /// From an [Event]
  Event.fromEvent(Event event)
      : name = event.name,
        description = event.description,
        location = Location.fromLocation(event.location),
        id = event.id,
        route = List<Coordinates>()..addAll(event.route),
        imageUrl = event.imageUrl,
        isFeatured = event.isFeatured,
        stops = event.stops;

  /// From a [map]
  Event.fromJson(Map<String, dynamic> map)
      : name = map['name'],
        description = map['description'],
        location = Location.fromJson(map['location']),
        id = map['id'],
        route = List<Coordinates>.from(
            (map['route'].cast<Map<String, dynamic>>())
                .toList()
                .map((map) => Coordinates.fromJson(map))),
        imageUrl = map['imageUrl'],
        isFeatured = map['isFeatured'],
        stops = List<Coordinates>.from(
            (map['stops'].cast<Map<String, dynamic>>())
                .toList()
                .map((map) => Coordinates.fromJson(map)));

  /// Convert [this] to a Json `Map<String, dynamic>`. Complex structures keep their initial
  /// types.
  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'location': location.toJson(),
        'id': id,
        'route': jsonDecode(jsonEncode(route)),
        'imageUrl': imageUrl,
        'isFeatured': isFeatured,
        'stops': jsonDecode(jsonEncode(stops)),
      };

  /// Convert [this] to a Json `Map<String, String>`. All complex structures
  /// are also converted to `String`.
  Map<String, String> toJson2() => {
        'name': name,
        'description': description,
        'location': jsonEncode(location),
        'id': id,
        'route': jsonEncode(route),
        'imageUrl': imageUrl,
        'isFeatured': jsonEncode(isFeatured),
        'stops': jsonEncode(stops),
      };

  /// Append [coordinates] to the [route]
  void appendRoute(List<Coordinates> coordinates) {
    route.addAll(coordinates);
  }
}
