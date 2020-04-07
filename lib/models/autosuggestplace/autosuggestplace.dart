class AutoSuggestPlace {
  final String placeId;
  final String description;
  final String id;
  final PlaceFormatting placeFormatting;

  AutoSuggestPlace(
      {this.placeId, this.description, this.id, this.placeFormatting});

  factory AutoSuggestPlace.fromJson(Map<String, dynamic> json) {
    return AutoSuggestPlace(
        description: json['description'],
        id: json['id'],
        placeId: json['place_id'],
        placeFormatting:
            PlaceFormatting.fromJson(json['structured_formatting']));
  }
}

class PlaceFormatting {
  final String mainText;
  final String secondaryText;

  PlaceFormatting({this.mainText, this.secondaryText});

  factory PlaceFormatting.fromJson(Map<String, dynamic> json) {
    return PlaceFormatting(
        mainText: json['main_text'], secondaryText: json['secondary_text']);
  }
}
