import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hnh/domain/entities/location.dart';
import 'package:hnh/domain/entities/weather.dart';

/// GPSDetails timer until the event
class GPSDetails extends StatelessWidget {

  final Location _location;
  final Weather _weather;

  GPSDetails(this._location, this._weather);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              getExpanded('Speed mph', _location.speedInMiles.toStringAsPrecision(2), 10),
              getExpanded('Temp', '${_weather.temperature.toStringAsFixed(0)}℉', 8),
              getExpanded('s', 'd', 8),

            ],
          ),
        )
      ],
    );
  }

  Expanded getExpanded(String title, String content, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          height: 80.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(15.0),
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
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
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
            ],
          ),
        ),
      ),
    );
  }
}
