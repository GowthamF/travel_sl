import 'package:bloc/bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:meta/meta.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository routeRepository = RouteRepository();

  @override
  // TODO: implement initialState
  RouteState get initialState => RouteEmpty();

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    if (event is GetRoute) {
      yield RouteLoading();

      try {
        final List<Routes> drivingRoutes = await routeRepository.getRoutes(
            event.origin, event.destination, '', TravelMode.Driving);
        final List<Routes> busRoute = await routeRepository.getRoutes(
            event.origin, event.destination, event.mode, TravelMode.Bus);
        final List<Routes> trainRoutes = await routeRepository.getRoutes(
            event.origin, event.destination, event.mode, TravelMode.Train);

        yield RouteLoaded(
            drivingRoutes: drivingRoutes,
            busRoutes: busRoute,
            trainRoutes: trainRoutes);
      } catch (ex) {
        print(ex);
        yield RouteError();
      }
    }
  }
}
