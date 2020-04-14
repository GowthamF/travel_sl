import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class RouteApiClient {
  final http.Client httpClient = http.Client();

  Future<List<Routes>> getRoute(dynamic origin, dynamic destination,
      dynamic mode, TravelMode transitMode) async {
    String _transitMode = '';
    if (transitMode == TravelMode.Bus) {
      _transitMode = 'bus';
    } else if (transitMode == TravelMode.Train) {
      _transitMode = 'train';
    } else if (transitMode == TravelMode.Driving) {
      _transitMode = 'driving';
    }

    final response = await httpClient.get(
        '${Constants.baseUrl}/api/directions/json?origin=$origin&destination=$destination&mode=$mode&transit_mode=$_transitMode&alternatives=true&key=${Constants.apiKey}');

    List<Routes> _routes = [];

    if (response.statusCode == 200) {
      dynamic _direction = json.decode(response.body)['routes'];

      for (var i = 0; i < _direction.length; i++) {
        var route = Routes.fromJson(_direction[i], transitMode);
        _routes.add(route);
      }
    }

    return _routes;
  }
}
