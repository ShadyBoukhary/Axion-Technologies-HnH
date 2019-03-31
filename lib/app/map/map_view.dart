import 'package:flutter/material.dart';
import 'package:hnh/app/components/hhDrawer.dart';
import 'package:hnh/app/map/map_controller.dart';
import 'package:hnh/app/abstract/view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPageView createState() => _MapPageView(MapController());
}

class _MapPageView extends View<MapPage> {
  MapController _controller;

  _MapPageView(this._controller);

  void callHandler(Function fn, {Map<String, dynamic> params}) {
    setState(() {
      if (params == null) {
        fn();
      } else {
        fn(params);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController _mapController;

    return Scaffold(
      drawer: Drawer(elevation: 8.0, child: View.drawer),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
}
