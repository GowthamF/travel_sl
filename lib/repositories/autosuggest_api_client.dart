import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class AutoSuggestApiClient {
  final http.Client httpClient = http.Client();

  Future<List<AutoSuggestPlace>> getAutoSuggest(
      String input, String location) async {
    final response = await httpClient.get(
        '${Constants.baseUrl}/api/place/autocomplete/json?key=${Constants.apiKey}&input=$input&location=$location&radius=1500');

    List<AutoSuggestPlace> _autoSuggestions = [];

    if (response.statusCode == 200) {
      dynamic suggestions = json.decode(response.body)['predictions'];

      for (var i = 0; i < suggestions.length; i++) {
        var route = AutoSuggestPlace.fromJson(suggestions[i]);
        _autoSuggestions.add(route);
      }
    }

    return _autoSuggestions;
  }
}
