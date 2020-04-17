import 'package:bloc/bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository routeRepository = RouteRepository();

  @override
  RouteState get initialState => RouteEmpty();

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    if (event is GetRoute) {
      yield RouteLoading();

      try {
        final List<Routes> busRoute = [];
        final List<Routes> trainRoutes = [];
        final List<Routes> drivingRoutes = await routeRepository.getRoutes(
            event.origin, event.destination, '', TravelMode.Driving);
        var _busRoutes = await routeRepository.getRoutes(
            event.origin, event.destination, event.mode, TravelMode.Bus);
        var _trainRoutes = await routeRepository.getRoutes(
            event.origin, event.destination, event.mode, TravelMode.Train);

        for (var i = 0; i < _busRoutes.length; i++) {
          for (var j = 0; j < _busRoutes[i].getLegs.length; j++) {
            for (var k = 0; k < _busRoutes[i].getLegs[j].getSteps.length; k++) {
              if (_busRoutes[i]
                      .getLegs[j]
                      .getSteps[k]
                      .transitDetails
                      .vehicleType ==
                  VehicleType.Bus) {
                busRoute.addAll(_busRoutes);
                break;
              }
            }
            break;
          }
          break;
        }

        for (var i = 0; i < _trainRoutes.length; i++) {
          for (var j = 0; j < _trainRoutes[i].getLegs.length; j++) {
            for (var k = 0;
                k < _trainRoutes[i].getLegs[j].getSteps.length;
                k++) {
              if (_trainRoutes[i]
                      .getLegs[i]
                      .getSteps[k]
                      .transitDetails
                      .vehicleType ==
                  VehicleType.Train) {
                trainRoutes.addAll(_trainRoutes);
                break;
              }
            }
            break;
          }
          break;
        }

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
