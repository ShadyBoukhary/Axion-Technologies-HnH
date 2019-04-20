import 'package:flutter/material.dart';
import 'package:hnh/app/components/local_place_card.dart';
import 'package:hnh/domain/entities/local_place.dart';

/// Restaurants Tab used in LocalPlacesView
class RestaurantsTab extends StatelessWidget {
  final List<LocalPlace> _restaurants;
  RestaurantsTab(this._restaurants);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(_restaurants));
  }
}

/// Hotels Tab used in LocalPlacesView
class HotelsTab extends StatelessWidget {
  final List<LocalPlace> _hotels;
  HotelsTab(this._hotels);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(_hotels));
  }
}

/// Constructs a body for either tabs using
Widget getBody(List<LocalPlace> localPlaces) {

  // return a list of LocalPlaceCards if there are places
  if (localPlaces.length > 0) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          itemCount: localPlaces.length,
          itemBuilder: (BuildContext ctxt, int index) => LocalPlaceCard(localPlaces[index]),
          padding: EdgeInsets.symmetric(horizontal: 10.0)),
    );
  }

  // returna centered text if there are no local places
  return Center(
    child: Text(
    'Nothing found. Try again later.',
    style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w500),
  ));
}
