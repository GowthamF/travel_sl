import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/repositories.dart';

class AutoSuggestRepository {
  final AutoSuggestApiClient autoSuggestApiClient = AutoSuggestApiClient();

  Future<List<AutoSuggestPlace>> getAutoSuggestions(
      String input, String location) async {
    return await autoSuggestApiClient.getAutoSuggest(input, location);
  }
}
