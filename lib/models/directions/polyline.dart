class PolyLine {
  final String points;

  PolyLine({this.points});

  String get getPoints => points;

  factory PolyLine.fromJson(Map<String, dynamic> json) {
    return PolyLine(points: json['points']);
  }
}
