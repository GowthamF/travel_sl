import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class TranslatorApiClient {
  final http.Client httpClient = http.Client();
  final List<TranslatedText> _translatedTexts = [];

  Future<List<TranslatedText>> getTranslated(List<String> inputText,
      String sourceLanguage, String targetLanguage) async {
    Map<String, dynamic> requestBody = {
      'q': inputText,
      'target': targetLanguage,
      'source': sourceLanguage
    };
    var jsonBody = json.encode(requestBody);

    final response =
        await httpClient.post(Constants.translationApiUrl, body: jsonBody);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body)['data']['translations'];

      for (var i = 0; i < jsonResponse.length; i++) {
        _translatedTexts.add(
            TranslatedText(translatedText: jsonResponse[i]['translatedText']));
      }
      print(_translatedTexts.first.translatedText);
    }
    return _translatedTexts;
  }
}
