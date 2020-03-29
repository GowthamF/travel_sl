import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/repositories/repositories.dart';

class CurrentLocationBloc
    extends Bloc<CurrentLocationEvent, CurrentLocationState> {
  final LocationRepository locationRepository = LocationRepository();

  @override
  CurrentLocationState get initialState => CurrentLocationEmpty();

  @override
  Stream<CurrentLocationState> mapEventToState(
      CurrentLocationEvent event) async* {
    if (event is GetCurrentLocation) {
      yield CurrentLocationLoading();

      try {
        final Position position = await locationRepository.getCurrentLocation();
        yield CurrentLocationLoaded(position: position);
      } catch (_) {
        yield CurrentLocationError();
      }
    }
  }
}
