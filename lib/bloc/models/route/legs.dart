import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/bloc/models/route/distance.dart';
import 'package:travel_sl/bloc/models/route/durations.dart';
import 'package:travel_sl/bloc/models/route/endlocation.dart';
import 'package:travel_sl/bloc/models/route/startlocation.dart';
import 'package:travel_sl/bloc/models/route/steps.dart';

class Legs {
  final Distance distance;
  final Durations durations;
  final String endaddress;
  final EndLocation endlocation;
  final String startaddress;
  final StartLocation startlocation;
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
  EndLocation get getEndLocation => endlocation;
  String get getStartAddress => startaddress;
  StartLocation get getStartLocation => startlocation;
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
        endlocation: EndLocation.fromJson(json['end_location']),
        startlocation: StartLocation.fromJson(json['start_location']),
        steps: _steps);
  }
}
