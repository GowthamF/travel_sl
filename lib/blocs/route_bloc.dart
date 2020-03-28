import 'package:bloc/bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:meta/meta.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RouteRepository routeRepository;

  RouteBloc({@required this.routeRepository}) : assert(routeRepository != null);

  @override
  // TODO: implement initialState
  RouteState get initialState => RouteEmpty();

  @override
  Stream<RouteState> mapEventToState(RouteEvent event) async* {
    if (event is GetRoute) {
      yield RouteLoading();

      try {
        final List<Routes> routes =
            await routeRepository.getRoutes(event.origin, event.destination);
        yield RouteLoaded(routes: routes);
      } catch (_) {
        yield RouteError();
      }
    }
  }
}
