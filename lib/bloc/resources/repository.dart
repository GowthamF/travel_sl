import 'package:travel_sl/bloc/api_provider/place_api_provider.dart';
import 'package:travel_sl/bloc/api_provider/route_api_provider.dart';
import 'package:travel_sl/bloc/models/directions/routes.dart';
import 'package:travel_sl/bloc/models/places/busstations.dart';
import 'package:travel_sl/bloc/models/places/trainstations.dart';

class Repository {
  final RouteApiProvider routeApiProvider = RouteApiProvider();
  final PlaceApiProvider placeApiProvider = PlaceApiProvider();

  Future<List<Routes>> getRoutes(dynamic origin, dynamic destination) =>
      routeApiProvider.getRoute(origin, destination);

  Future<List<BusStations>> getBusStations(dynamic location) =>
      placeApiProvider.getBusStations(location);

  Future<List<TrainStations>> getTrainStations(dynamic location) =>
      placeApiProvider.getTrainStations(location);
}
