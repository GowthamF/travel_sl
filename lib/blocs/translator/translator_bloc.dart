import 'package:bloc/bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/repositories/repositories.dart';

class TranslatorBloc extends Bloc<TranslatorEvent, TranslatorState> {
  final TranslatorRepository translatorRepository = TranslatorRepository();

  @override
  // TODO: implement initialState
  TranslatorState get initialState => TranslatorEmpty();

  @override
  Stream<TranslatorState> mapEventToState(TranslatorEvent event) async* {
    if (event is GetTranslationText) yield TranslatorLoading();

    try {} catch (e) {}
  }
}
