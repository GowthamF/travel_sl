import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class TranslatorRepository {
  final TranslatorApiClient translatorApiClient = TranslatorApiClient();

  Future<List<TranslatedText>> getTranslatedText(List<String> inputText,
      String sourceLanguage, String targetLanguage) async {
    return await translatorApiClient.getTranslated(
        inputText, sourceLanguage, targetLanguage);
  }
}
