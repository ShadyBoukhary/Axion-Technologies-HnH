import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hnh/app/pages/pages.dart';

class Router {
  final RouteObserver<PageRoute> routeObserver;

  Router() : routeObserver = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings) {
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
}
