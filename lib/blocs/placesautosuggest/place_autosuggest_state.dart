import 'package:equatable/equatable.dart';
import 'package:travel_sl/models/autosuggestplace/autosuggestplace.dart';

abstract class PlaceAutoSuggestState extends Equatable {
  const PlaceAutoSuggestState();

  @override
  List<Object> get props => [];
}

class PlaceAutoSuggestEmpty extends PlaceAutoSuggestState {}

class PlaceAutoSuggestLoading extends PlaceAutoSuggestState {}

class PlaceAutoSuggestLoaded extends PlaceAutoSuggestState {
  final List<AutoSuggestPlace> autoSuggestions;
  final bool isOrigin;

  const PlaceAutoSuggestLoaded({this.autoSuggestions, this.isOrigin});

  @override
  List<Object> get props => [autoSuggestions, isOrigin];
}

class PlaceAutoSuggestError extends PlaceAutoSuggestState {}
