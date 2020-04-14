import 'package:travel_sl/models/models.dart';

class TranslatorSingletom {
  static final TranslatorSingletom _translatorSingletom =
      TranslatorSingletom._internal();

  TranslatorSingletom._internal();

  static TranslatorSingletom getInstance() => _translatorSingletom;
}
