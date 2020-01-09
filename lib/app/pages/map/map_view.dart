import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hnh/app/components/gps_details.dart';
import 'package:hnh/app/pages/map/map_controller.dart';
import 'package:hnh/data/repositories/data_weather_repository.dart';
import 'package:hnh/device/repositories/device_location_repository.dart';
import 'package:hnh/domain/entities/event.dart';

class MapPage extends View {
  MapPage({Key key, @required this.event}) : super(key: key);

  final Event event;

  @override
  _MapPageView createState() => _MapPageView(event);
}

class _MapPageView extends ViewState<MapPage, MapController>
    with SingleTickerProviderStateMixin {
  _MapPageView(event)
      : super(MapController(
            DeviceLocationRepository(), DataWeatherRepository(), event));

  @override
  Widget buildPage() {
    return WillPopScope(
      key: globalKey,
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Stack(
            children: <Widget>[mapContainer, getTracker()],
          ),
        ),
      ),
      onWillPop: () async {
        // fixes a bug where if the user clicks on the appbar back button and clicks outside
        // the dialog, the material button returns null and crashes the app
        // this processes the dialog result manually
        bool result = await _showDialog();
        return result != null ? Future.value(result) : Future.value(false);
      },
    );
  }

  AppBar get appBar => AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RawMaterialButton(
              textStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w500),
              child: Text(
                  controller.isNavigating ? 'Unlock Camera' : "Lock Camera"),
              onPressed: () => controller.handleStart(),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      );

  Container get mapContainer => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          onMapCreated: (controller1) {
            controller.googleMapsOnInit({'controller': controller1});
          },
          initialCameraPosition: CameraPosition(
            target: controller.initial,
            zoom: 11,
          ),
          myLocationEnabled: true,
          polylines: controller.polylines,
          markers: controller.markers,
        ),
      );

  Widget getTracker() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: GPSDetails(
            controller.currentLocation,
            controller.currentWeather,
            widget.event.name,
            controller.remainingDistance,
            controller.distanceTravelled));
  }

  Future<bool> _showDialog() {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Exit Session"),
              content: Text("Are you sure you want to end this session?"),
              actions: <Widget>[
                FlatButton(
                    child: Text("Yes"),
                    onPressed: () => Navigator.of(context).pop(true)),
                FlatButton(
                  child: Text("No"),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
