import 'package:geolocator/geolocator.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:meta/meta.dart';

class RouteRepository {
  final RouteApiClient routeApiClient = RouteApiClient();

  Future<List<Routes>> getRoutes(dynamic origin, dynamic destination) async {
    return await routeApiClient.getRoute(origin, destination);
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
