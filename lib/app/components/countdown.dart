import 'package:flutter/material.dart';
import 'dart:async';

/// Countdown timer until the event
class Countdown extends StatefulWidget {
  final DateTime _eventTime;
  final Function _notifyParent;
  Countdown(this._eventTime, this._notifyParent);

  @override
  CountdownState createState() => CountdownState(_eventTime, _notifyParent);
}

class CountdownState extends State<Countdown> {

  // Members
  DateTime _eventTime;
  Duration _timeDifference;
  Timer _timer;
  Function _notifyParent; // callback function that updates the parent widget state

  // Properties
  int get days => _timeDifference.inDays;
  int get hours => _timeDifference.inHours - _timeDifference.inDays * 24;
  int get minutes => _timeDifference.inMinutes - _timeDifference.inHours * 60;
  int get seconds => _timeDifference.inSeconds - _timeDifference.inMinutes * 60;

  CountdownState(this._eventTime, this._notifyParent) {
    _timer = Timer.periodic(Duration(seconds: 1), _updateTime);
    _timeDifference = Duration(seconds: 0);
  }

  /// Calculates the time difference between the current time and the [_eventTime]
  Duration timeDifference() {
    return _eventTime.difference(DateTime.now());
  }

  /// Updates the [_timeDifference] between the current time and the [_eventTime].
  /// If the [_timeDifference] in seconds in less than than 1, the timer [t] is stopped.
  /// Once the [_timeDifference] is updated, the [CountdownState] state is updated and the
  /// parent `State` is updated as well.
  void _updateTime(Timer t) {

    // update parent state
    _notifyParent(() {
      // update this state
      setState(() {
        // update time difference
        _timeDifference = timeDifference();
        if (_timeDifference.inSeconds < 1) {
          t.cancel();
        }
      });
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
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 10.0,
                  ),
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(15.0),
                      backgroundBlendMode: BlendMode.softLight,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
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
                            text: "$days",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\nDays",
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
              ),
              Expanded(
                flex: 8,
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
                            text: "$hours",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\nHours",
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
              ),
              Expanded(
                flex: 8,
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
                            text: "$minutes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\nMinutes",
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
              ),
              Expanded(
                flex: 8,
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
                            text: "$seconds",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\nSeconds",
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
