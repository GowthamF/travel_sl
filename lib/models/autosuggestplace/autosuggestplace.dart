import 'package:flutter/material.dart';

class AutoSuggestPlace {
  final String placeId;
  final String description;
  final String id;
  final PlaceFormatting placeFormatting;
  final Icon placeIcon;
  final bool isCurrentLocation;
  final bool isRecentSearch;

  AutoSuggestPlace(
      {this.placeId,
      this.description,
      this.id,
      this.placeFormatting,
      this.placeIcon,
      this.isCurrentLocation,
      this.isRecentSearch});

  factory AutoSuggestPlace.fromJson(Map<String, dynamic> json) {
    return AutoSuggestPlace(
        description: json['description'],
        id: json['id'],
        placeId: json['place_id'],
        placeFormatting: PlaceFormatting.fromJson(
          json['structured_formatting'],
        ),
        placeIcon: Icon(Icons.location_on),
        isCurrentLocation: false);
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
