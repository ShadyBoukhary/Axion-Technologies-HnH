import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hnh/app/event/event_view.dart';
import 'package:hnh/app/events/events_view.dart';
import 'package:hnh/app/local_places/local_places_view.dart';
import 'package:hnh/app/map/map_view.dart';
import 'package:hnh/app/splash/splash_view.dart';
import 'package:hnh/app/sponsors/sponsors_view.dart';
import 'package:hnh/app/user_events/user_events_view.dart';
import 'package:logging/logging.dart';
import 'home/home_view.dart';
import 'login/login_view.dart';
import 'register/register_view.dart';
import 'package:hnh/app/web/web_view.dart';
import 'package:map_view/map_view.dart';
import 'package:hnh/data/utils/sensitive.dart';


void main() { 
  MapView.setApiKey(googleApiKey);
  runApp(MyApp()); 
  }

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  MyApp() {
    initLogger();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black38));

    return MaterialApp(
      title: "Hotter'n Hell",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        accentColor: Colors.redAccent,
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide:
                  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide:
                  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: Color.fromRGBO(230, 38, 39, 0.8))),
          fillColor: Color.fromRGBO(255, 255, 255, 0.4),
          filled: true,
          hintStyle:
              TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _getRoute,
      navigatorObservers: [routeObserver],
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return _buildRoute(settings, HomePage());
      case '/login':
        return _buildRoute(settings, LoginPage());
      case '/register':
        return _buildRoute(settings, RegisterPage());
      case '/map':
        Map<String, dynamic> args = settings.arguments as Map;
        return _buildRoute(settings, MapPage(event: args['event']));
      case '/events':
        return _buildRoute(settings, EventsPage());
      case '/event':
        Map<String, dynamic> args = settings.arguments as Map;
        return _buildRoute(
            settings,
            EventPage(
                event: args['event'],
                user: args['user'],
                isUserEvent: args['isUserEvent']));
      case '/userEvents':
        Map<String, dynamic> args = settings.arguments as Map;
        return _buildRoute(
            settings, UserEventsPage(routeObserver, user: args['user']));
      case '/sponsors':
        return _buildRoute(settings, SponsorsPage());
      case '/localPlaces':
        return _buildRoute(settings, LocalPlacesPage());
      case '/web':
        Map<String, String> args = settings.arguments as Map;
        return _buildRoute(
            settings, WebPage(title: args['title'], url: args['url']));
      default:
        return null;
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  void initLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      dynamic e = record.error;
      print(
          '${record.loggerName}: ${record.level.name}: ${record.message} ${e != null ? e?.message : ''}');
    });
    Logger.root.info("Logger initialized.");
  }
}
