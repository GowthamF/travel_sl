class TravelTime {
  final String text;

  TravelTime({this.text});

  factory TravelTime.fromJson(Map<String, dynamic> json) {
    return TravelTime(text: json['text']);
  }
}
