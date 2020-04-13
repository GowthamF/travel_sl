import 'package:bloc/bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class CurrentAddressBloc
    extends Bloc<CurrentAddressEvent, CurrentAddressState> {
  final RouteRepository routeRepository = RouteRepository();

  @override
  // TODO: implement initialState
  CurrentAddressState get initialState => CurrentAddressEmpty();

  @override
  Stream<CurrentAddressState> mapEventToState(
      CurrentAddressEvent event) async* {
    if (event is GetAddressInfo) {
      yield CurrentAddressEmpty();

      try {
        final List<MarkerAddress> address =
            await routeRepository.getLocationAddress(event.coordinates);
        yield CurrentAddressLoaded(address: address);
      } catch (ex) {
        print(ex);
        yield CurrentAddressError();
      }
    }
  }
}
