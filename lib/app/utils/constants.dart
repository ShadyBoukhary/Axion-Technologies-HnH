import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hnh/domain/entities/coordinates.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

class UIConstants {
  static const TextStyle fieldHintStyle =
      TextStyle(fontWeight: FontWeight.w300, color: Colors.black);
  static const String appName = "Hotter'n Hell";
  static const double progressBarOpacity = 0.6;
  static const Color progressBarColor = Colors.black;
}

class Strings {
  static const String registrationFormIncomplete = 'Form must be filled out.';
  static const String tosNotAccepted =
      'Please accept the Terms of Service to register.';
  static const String registrationSuccessful = 'Registration Successful!';
}

class HHHConstants {
  static const String registrationUrl = 'https://www.hh100.org/sign-up';
}

class Resources {
  static const String background = 'assets/img/background.jpg';
  static const String logo = 'assets/img/logo.png';
  static const String loader = 'assets/img/loading.svg';
  static const String event_race = 'assets/img/event_race.jpg';
  static const String event_spaghetti = 'assets/img/event_spaghetti.jpg';
  static const String event_consumer = 'assets/img/event_consumer.jpg';
}

/// Returns the app's default snackbar with a [text].
SnackBar _getGenericSnackbar(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}

/// Shows a generic [Snackbar]
void showGenericSnackbar(GlobalKey<ScaffoldState> key, String text,
    {bool isError = false}) {
  key.currentState.showSnackBar(_getGenericSnackbar(text, isError));
}

/// Launches Apple Maps or Google Maps, whichever is available with the
/// [event.location] to navigate to the event if not a race
void launchMaps(Coordinates coordinates, Logger logger, key) async {
  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${coordinates.lat},${coordinates.lon}';
  String url = '';
  if (Platform.isIOS) {
    String googleUrl = 'comgooglemaps://?q=${coordinates.lat},${coordinates.lon}';
    String appleUrl = 'https://maps.apple.com/?q=${coordinates.lat},${coordinates.lon}';
    if (await canLaunch(googleUrl)) {
      url = googleUrl;
    } else if (await canLaunch(appleUrl)) {
      url = appleUrl;
    }
  } else if (Platform.isAndroid && await canLaunch(googleUrl)) {
    url = googleUrl;
  }

  if (url != '') {
    logger.info('launching: $url');
    await launch(url);
  } else {
    showGenericSnackbar(key, 'A problem occured.');
  }
}
