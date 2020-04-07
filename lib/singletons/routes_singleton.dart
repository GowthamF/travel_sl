import 'package:travel_sl/models/models.dart';

class RoutesSingleTon {
  static final RoutesSingleTon _location = RoutesSingleTon._internal();

  RoutesSingleTon._internal();

  static RoutesSingleTon getInstance() => _location;

  List<Routes> drivingRoutes = [];
  List<Routes> transitRoutes = [];

  void Function() addLocation;
}
