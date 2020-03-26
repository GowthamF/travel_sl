import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:travel_sl/bloc/models/route/routes.dart';
import 'package:travel_sl/bloc/resources/contants.dart';

class RouteApiProvider {
  Client client = Client();

  Future<List<Routes>> getRoute(dynamic origin, dynamic destination) async {
    final response = await client.get(
        '${Constants.baseUrl}api/directions/json?origin=$origin&destination=$destination&alternatives=true&key=${Constants.apiKey}');

    List<Routes> _routes = [];

    if (response.statusCode == 200) {
      dynamic _direction = json.decode(response.body)['routes'];

      for (var i = 0; i < _direction.length; i++) {
        var route = Routes.fromJson(_direction[i]);
        _routes.add(route);
      }
    }

    return _routes;
  }
}
