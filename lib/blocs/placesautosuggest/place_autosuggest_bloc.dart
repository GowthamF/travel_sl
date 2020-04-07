import 'package:bloc/bloc.dart';
import 'package:travel_sl/blocs/placesautosuggest/place_autosuggest_event.dart';
import 'package:travel_sl/blocs/placesautosuggest/place_autosuggest_state.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/autosuggest_repository.dart';

class PlaceAutoSuggestBloc
    extends Bloc<PlaceAutoSuggestEvent, PlaceAutoSuggestState> {
  final AutoSuggestRepository autoSuggestRepository = AutoSuggestRepository();

  @override
  // TODO: implement initialState
  PlaceAutoSuggestState get initialState => PlaceAutoSuggestEmpty();

  @override
  Stream<PlaceAutoSuggestState> mapEventToState(
      PlaceAutoSuggestEvent event) async* {
    if (event is GetAutoSuggestions) {
      yield PlaceAutoSuggestLoading();

      try {
        final List<AutoSuggestPlace> autoSuggestions =
            await autoSuggestRepository.getAutoSuggestions(
                event.input, event.location);

        yield PlaceAutoSuggestLoaded(
            autoSuggestions: autoSuggestions, isOrigin: event.isOrigin);
      } catch (_) {
        yield PlaceAutoSuggestError();
      }
    }
  }
}
