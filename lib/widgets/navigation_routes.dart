import 'package:flutter/material.dart';
import 'package:travel_sl/widgets/widgets.dart';

class NavigationRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '$map':
        var route = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => GMap(route));
      case '$directions':
        var route = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => Directions(
                  route: route,
                ));
      case '$buses':
        return MaterialPageRoute(builder: (_) => Buses());
      case '$trains':
        return MaterialPageRoute(builder: (_) => Trains());
      case '$places':
        return MaterialPageRoute(builder: (_) => Places());
      case '$translator':
        return MaterialPageRoute(builder: (_) => Translator());
      default:
        return MaterialPageRoute(builder: null);
    }
  }

  static const String directions = 'Directions';
  static const String buses = 'Buses';
  static const String trains = 'Trains';
  static const String home = 'Home';
  static const String map = 'Map';
  static const String translator = 'Translator';
  static const String places = 'Places';
}
