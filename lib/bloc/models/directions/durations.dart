class Durations {
  final String text;
  final int value;

  Durations({this.text, this.value});

  String get getText => text;
  int get getValue => value;

  factory Durations.fromJson(Map<String, dynamic> json) {
    return Durations(text: json['text'], value: json['value']);
  }
}
