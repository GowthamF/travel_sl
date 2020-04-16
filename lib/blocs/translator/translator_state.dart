import 'package:equatable/equatable.dart';

abstract class TranslatorState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TranslatorEmpty extends TranslatorState {}

class TranslatorLoading extends TranslatorState {}

class TranslatorLoaded extends TranslatorState {
  final String translatedText;

  TranslatorLoaded({this.translatedText});

  @override
  // TODO: implement props
  List<Object> get props => [translatedText];
}

class TranslatorError extends TranslatorState {}
