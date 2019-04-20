import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/weather.dart';

/// GPSDetails timer until the event
class GPSDetails extends StatelessWidget {
  final Location _location;
  final Weather _weather;
  final String _name;
  final String _remainingDistance;
  final String _distanceTravelled;

  GPSDetails(this._location, this._weather, this._name, this._remainingDistance, this._distanceTravelled);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        backgroundBlendMode: BlendMode.colorBurn,
        color: Colors.black.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 10, color: Colors.grey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              getUnitColumn(
                  'Speed mph', _location.speedInMiles.toStringAsPrecision(2)),
              getUnitColumn(
                  'Temp', '${_weather.temperature.toStringAsFixed(0)}℉'),
                  getUnitColumn('Rem. miles', _remainingDistance),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              getUnitColumn('Wind ↢', '${_weather.windDegrees}'),
              getUnitColumn('Wind mph', '${_weather.windSpeed}'),
              getUnitColumn('Travelled', _distanceTravelled)
            ],
          ),
        ],
      ),
    );
  }

  Column getUnitColumn(String title, String content) {
    return Column(
      children: <Widget>[getUnitBox(title, content)],
    );
  }

  Widget getUnitBox(String title, String content) {
    return Container(
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: "$content",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            TextSpan(
              text: "\n$title",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
