import 'package:rxdart/rxdart.dart';
import 'package:travel_sl/bloc/models/route/routes.dart';
import 'package:travel_sl/bloc/resources/repository.dart';

class RouteBloc {
  final Repository _repository = Repository();

  BehaviorSubject<List<Routes>> _routesFetcher =
      BehaviorSubject<List<Routes>>();

  Stream<List<Routes>> get getRoutes => _routesFetcher.stream;

  getRoute(dynamic origin, dynamic destination) async {
    List<Routes> routes = await _repository.getRoutes(origin, destination);
    _routesFetcher.sink.add(routes);
  }

  dispose() {
    _routesFetcher.close();
  }
}

final RouteBloc routeBloc = RouteBloc();
