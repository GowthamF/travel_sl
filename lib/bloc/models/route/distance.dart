class Distance {
  final String text;
  final int value;

  Distance({this.text, this.value});

  String get getText => text;
  int get getValue => value;

  factory Distance.fromJson(Map<String, dynamic> json) {
    return Distance(text: json['text'], value: json['value']);
  }
}
