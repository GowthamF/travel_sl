import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:travel_sl/bloc/models/places/busstations.dart';
import 'package:travel_sl/bloc/models/places/trainstations.dart';
import 'package:travel_sl/bloc/resources/contants.dart';

class PlaceApiProvider {
  Client client = Client();

  Future<List<BusStations>> getBusStations(dynamic location) async {
    final response = await client.get(
        '${Constants.baseUrl}/api/place/nearbysearch/json?location=$location&radius=1500&type=bus_station&key=${Constants.apiKey}');

    List<BusStations> _busStations = [];

    if (response.statusCode == 200) {
      dynamic busStations = json.decode(response.body);

      for (var i = 0; i < busStations.length; i++) {
        _busStations.add(BusStations.fromJson(busStations));
      }
    }

    return _busStations;
  }

  Future<List<TrainStations>> getTrainStations(dynamic location) async {
    final response = await client.get(
        '${Constants.baseUrl}/api/place/nearbysearch/json?location=$location&radius=1500&type=train_station&key=${Constants.apiKey}');

    List<TrainStations> _trainStations = [];

    if (response.statusCode == 200) {
      dynamic trainStations = json.decode(response.body);

      for (var i = 0; i < trainStations.length; i++) {
        _trainStations.add(TrainStations.fromJson(trainStations));
      }
    }

    return _trainStations;
  }
}
