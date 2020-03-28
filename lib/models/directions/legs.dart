import 'package:travel_sl/models/models.dart';

class Legs {
  final Distance distance;
  final Durations durations;
  final String endaddress;
  final Location endlocation;
  final String startaddress;
  final Location startlocation;
  final List<Steps> steps;

  Legs(
      {this.distance,
      this.durations,
      this.endaddress,
      this.endlocation,
      this.startlocation,
      this.startaddress,
      this.steps});

  Distance get getDistance => distance;
  Durations get getDurations => durations;
  String get getEndAddress => endaddress;
  Location get getEndLocation => endlocation;
  String get getStartAddress => startaddress;
  Location get getStartLocation => startlocation;
  List<Steps> get getSteps => steps;

  factory Legs.fromJson(Map<String, dynamic> json) {
    var steps = json['steps'];

    List<Steps> _steps = [];

    for (var i = 0; i < steps.length; i++) {
      _steps.add(Steps.fromJson(steps[i]));
    }

    return Legs(
        distance: Distance.fromJson(json['distance']),
        durations: Durations.fromJson(json['duration']),
        endaddress: json['end_address'],
        startaddress: json['start_address'],
        endlocation: Location.fromJson(json['end_location']),
        startlocation: Location.fromJson(json['start_location']),
        steps: _steps);
  }
}
