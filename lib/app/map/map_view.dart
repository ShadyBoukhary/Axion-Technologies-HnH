import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hnh/app/map/map_controller.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:hnh/domain/entities/event.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';


class MapPage extends StatefulWidget {
  MapPage({Key key, @required this.event}) : super(key: key);

  Event event;

  @override
  _MapPageView createState() => _MapPageView(MapController(DeviceLocationRepository() ,event));
}

class _MapPageView extends View<MapPage> {
  MapController _controller;

  _MapPageView(this._controller);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(elevation: 8.0, child: View.drawer),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: (controller) {
                callHandler(_controller.googleMapsOnInit, params: { 'controller': controller});
              },
              initialCameraPosition: CameraPosition(
                target: _controller.initial,
                zoom: 12,
              ),
              myLocationEnabled: true,
              polylines: _controller.polylines,
              
              
              
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
              title: Text(
                'Maps',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.black.withOpacity(0.5),
              centerTitle: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //mapView.dismiss();
    _controller.dispose();
    super.dispose();
  }
}

