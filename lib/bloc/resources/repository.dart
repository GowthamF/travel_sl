import 'package:travel_sl/bloc/api_provider/route_api_provider.dart';
import 'package:travel_sl/bloc/models/route/routes.dart';

class Repository {
  final RouteApiProvider routeApiProvider = RouteApiProvider();

  Future<List<Routes>> getRoutes(dynamic origin, dynamic destination) =>
      routeApiProvider.getRoute(origin, destination);
}
