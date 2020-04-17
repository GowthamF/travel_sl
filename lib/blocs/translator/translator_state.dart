import 'package:equatable/equatable.dart';
import 'package:travel_sl/models/models.dart';

abstract class TranslatorState extends Equatable {
  @override
  List<Object> get props => [];
}

class TranslatorEmpty extends TranslatorState {}

class TranslatorLoading extends TranslatorState {}

class TranslatorLoaded extends TranslatorState {
  final List<TranslatedText> translatedText;

  TranslatorLoaded({this.translatedText});

  @override
  List<Object> get props => [translatedText];
}

class TranslatorError extends TranslatorState {}
