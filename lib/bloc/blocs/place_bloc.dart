import 'package:rxdart/rxdart.dart';
import 'package:travel_sl/bloc/models/places/busstations.dart';
import 'package:travel_sl/bloc/models/places/trainstations.dart';
import 'package:travel_sl/bloc/resources/repository.dart';

class PlaceBloc {
  final Repository _repository = Repository();

  BehaviorSubject<List<BusStations>> busStationsFetcher =
      BehaviorSubject<List<BusStations>>();

  BehaviorSubject<List<TrainStations>> trainStationFetcher =
      BehaviorSubject<List<TrainStations>>();

  Stream<List<BusStations>> get getBusStationsList => busStationsFetcher.stream;

  Stream<List<TrainStations>> get getTrainStationsList =>
      trainStationFetcher.stream;

  getBusStations(dynamic location) async {
    List<BusStations> _busStation = await _repository.getBusStations(location);
    busStationsFetcher.sink.add(_busStation);
  }

  getTrainStations(dynamic location) async {
    List<TrainStations> _trainStations =
        await _repository.getTrainStations(location);
    trainStationFetcher.sink.add(_trainStations);
  }

  dispose() {
    busStationsFetcher.close();
    trainStationFetcher.close();
  }
}
