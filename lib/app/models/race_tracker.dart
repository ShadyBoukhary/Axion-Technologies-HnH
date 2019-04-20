// Shady Boukhary

import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/domain/entities/coordinates.dart';

/// An [Event] that is a race and has self-tracking abilities for UI purposes.
/// Features include tracking its own [distanceTravelled], calculating its total
/// route distance, distance travelled, distance remaining, and navigation abilities.
class RaceTracker extends Event {
  // Members
  int lastVisitedPoint;
  double _totalDistance;
  double _distanceTravelled;
  Coordinates _lastKnownPosition;

  // Getters
  double get distanceTravelled => _distanceTravelled;

  // Default
  RaceTracker(name, description, location, id,
      [isFeatured, route, imageUrl, stops])
      : _totalDistance = -1,
        lastVisitedPoint = -1,
        _distanceTravelled = 0,
        super(name, description, location, id, isFeatured, route, imageUrl,
            stops);

  /// From an [Event]
  RaceTracker.fromEvent(Event event)
      : _totalDistance = -1,
        lastVisitedPoint = -1,
        _distanceTravelled = 0,
        super.fromEvent(event);

  /// From a [map]
  RaceTracker.fromJson(Map<String, dynamic> map)
      : _totalDistance = -1,
        lastVisitedPoint = -1,
        _distanceTravelled = 0,
        super.fromJson(map);

  /// Calculates the total distance of the [_route].
  /// Complexity: `O(n)` if called for the first time and `O(1)` if called again.
  /// Lazily calcualtes the total route for the race.
  double calculateRouteDistance({DistanceUnit unit = DistanceUnit.miles}) {
    if (_totalDistance != -1) {
      return _totalDistance;
    }

    _totalDistance = 0;
    for (int i = 0; i < route.length - 2; i++) {
      _totalDistance += route[i].distanceTo(route[i + 1], unit);
    }
    return _totalDistance;
  }

  /// Finds the remaining distance to the finish line given the [currentPosition].
  /// Calculated in a give [unit] of distance.
  /// Worst-case complexity of `O(n^2)`
  /// Average complexity: `O(n)`
  double _distanceRemaining(Coordinates currentPosition,
      {DistanceUnit unit = DistanceUnit.miles}) {
    if (lastVisitedPoint == -1) {
      return calculateRouteDistance();
    }

    double remainingDistance = 0;
    // Find the remaining distance starting from the current calculated index
    for (int i = lastVisitedPoint; i < route.length - 2; i++) {
      remainingDistance += route[i].distanceTo(route[i + 1], unit);
    }

    return remainingDistance;
  }

  /// Finds the closes [Coordinates] index in the [_route] to a given [currentPosition]
  /// in a specific [unit] of distance.
  /// `O(n)` complexity
  int _findClosest(Coordinates currentPosition, DistanceUnit unit) {
    int closestIdx = 0;
    double closestDistance =
        currentPosition.distanceTo(route[closestIdx], unit);

    /// `O(n - 1)` loop to find the shortest distance
    for (int i = 1; i < route.length - 1; i++) {
      double distance = currentPosition.distanceTo(route[i], unit);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestIdx = i;
      }
    }
    return closestIdx;
  }

  /// Finds the remaining distance to HG line given the [currentPosition].
  /// Calculated in a give [unit] of distance.
  /// Worst-case complexity of `O(n^2)`
  double distanceToHellsGate(Coordinates currentPosition,
      {DistanceUnit unit = DistanceUnit.miles}) {
    int start = lastVisitedPoint;
    if (lastVisitedPoint == -1) {
      start = 0;
    }

    double remainingDistance = 0;
    // find the closest point in the race to HG
    // this approach is used since HG is not a part of every route (only the 100 mile route)
    int hgIndex = _findClosest(hellsGate, unit);
    // distance already covered from last visited point to current user position
    // TODO: Figure out how to deal with distance between last visited and user's current position
    //double distanceCovered = currentPosition.distanceTo(_route[start], unit);
    // approximation of the distance between the closest point to HG in the route and
    // the real position of HG. This is necessary for the routes that actually do not
    // include HG along their routes
    double distanceFromClosestToHG = route[hgIndex].distanceTo(hellsGate, unit);
    // Find the remaining distance starting from the current calculated index
    for (int i = start; i < hgIndex - 1; i++) {
      remainingDistance += route[i].distanceTo(route[i + 1], unit);
    }

    // remaining distance + approx distance to HG - the distance already covered after passed the last visited point
    return remainingDistance + distanceFromClosestToHG;
  }

  /// Advance the user's position in the race.
  ///
  /// The distance from the user's [currentPosition] to the next [Coordinates] to be visited in
  /// the [_route] is calculated using the [unit] of choice.
  /// Then, if the [distanceToNext] is less than `16 meters`, the [lastVisitedPoint] is incremented,
  /// marking it as visited. The remaining distance to the last point in the race is calculated
  /// using [_distanceRemaining] in addition to the [distanceToNext].
  /// Worst-case complexity: `O(n^2)`
  /// Average complexity: `O(n)`
  double advancePosition(Coordinates currentPosition,
      {DistanceUnit unit = DistanceUnit.miles}) {
    if (_lastKnownPosition == null) {
      _lastKnownPosition = currentPosition;
    }
    _distanceTravelled += currentPosition.distanceTo(_lastKnownPosition, unit);

    // if already reached finish line
    if (lastVisitedPoint == route.length - 1) {
      return 0;
    }

    double distanceToNext =
        currentPosition.distanceTo(route[lastVisitedPoint + 1], unit);
    // if within 16 meters, visit point
    if (distanceToNext <= 0.01) {
      lastVisitedPoint++;
    }
    // the actual remaining distance is the distance to the point to be visited and the remaining distance
    // for the rest of the route
    return _distanceRemaining(currentPosition, unit: unit) + distanceToNext;
  }
}
