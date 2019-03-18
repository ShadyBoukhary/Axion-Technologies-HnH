import 'package:flutter/material.dart';
import 'package:hnh/app/components/countdown.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/map/map_controller.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  MapPageView createState() => MapPageView(MapController());
}

class MapPageView extends View<MapPage> {
  MapController _controller;

  MapPageView(this._controller);

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    return Scaffold(
      drawer: Drawer(elevation: 8.0, child: HhDrawer('Guest User', '')),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(-33.852, 151.211),
                zoom: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar get appBar => AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
}
