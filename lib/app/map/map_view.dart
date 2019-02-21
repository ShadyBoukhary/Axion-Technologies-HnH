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

class MapPageView extends State<MapPage> implements View {
  MapController _controller;

  MapPageView(this._controller);

  void callHandler(Function fn) {
    setState(() {
      fn();
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    return Scaffold(
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
}
