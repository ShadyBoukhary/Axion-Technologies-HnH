import 'package:flutter/material.dart';
import 'dart:async';

/// Countdown timer until the event
class Countdown extends StatefulWidget {
  final DateTime _eventTime;
  Countdown(this._eventTime);

  @override
  CountdownState createState() => CountdownState(_eventTime);
}

class CountdownState extends State<Countdown> {
  // Members
  DateTime _eventTime;
  Duration _timeDifference;
  Timer _timer;

  // Properties
  int get days => _timeDifference.inDays;
  int get hours => _timeDifference.inHours % 24;
  int get minutes => _timeDifference.inMinutes % 60;
  int get seconds => _timeDifference.inSeconds % 60;

  CountdownState(this._eventTime) {
    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);
    _timeDifference = _timeDifference = timeDifference();
  }

  /// Calculates the time difference between the current time and the [_eventTime]
  Duration timeDifference() {
    return _eventTime.difference(DateTime.now());
  }

  /// Updates the [_timeDifference] between the current time and the [_eventTime].
  /// If the [_timeDifference] in seconds in less than than 1, the timer [t] is stopped.
  /// Once the [_timeDifference] is updated, the [CountdownState] state
  void _updateTime(Timer t) {
    // update this state
    setState(() {
      // update time difference
      _timeDifference = timeDifference();
      if (_timeDifference.inSeconds < 1) {
        t.cancel();
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              getExpanded('Days', '$days', 10),
              getExpanded('Hours', '$hours', 8),
              getExpanded('Minutes', '$minutes', 8),
              getExpanded('Seconds', '$seconds', 8)
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
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 10.0,
                spreadRadius: 3.0,
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
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
