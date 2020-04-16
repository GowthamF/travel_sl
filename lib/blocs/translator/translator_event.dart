import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class TranslatorEvent extends Equatable {
  const TranslatorEvent();
}

class GetTranslationText extends TranslatorEvent {
  final List<String> translateTexts;
  final String target;
  final String source;

  const GetTranslationText(
      {@required this.translateTexts, this.target, this.source});

  @override
  // TODO: implement props
  List<Object> get props => [translateTexts, target, source];
}
