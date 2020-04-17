import 'package:equatable/equatable.dart';

abstract class PlaceAutoSuggestEvent extends Equatable {
  const PlaceAutoSuggestEvent();
}

class GetAutoSuggestions extends PlaceAutoSuggestEvent {
  final String input;
  final String location;
  final bool isOrigin;
  const GetAutoSuggestions({this.input, this.location, this.isOrigin});

  @override
  List<Object> get props => [input, location, isOrigin];
}
