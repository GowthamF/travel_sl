import 'package:travel_sl/bloc/models/route/distance.dart';
import 'package:travel_sl/bloc/models/route/durations.dart';
import 'package:travel_sl/bloc/models/route/endlocation.dart';
import 'package:travel_sl/bloc/models/route/startlocation.dart';

class Steps {
  final Distance distance;
  final Durations durations;
  final StartLocation startlocation;
  final EndLocation endLocation;

  Steps({this.distance, this.durations, this.startlocation, this.endLocation});

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      distance: Distance.fromJson(json['distance']),
      durations: Durations.fromJson(json['duration']),
      endLocation: EndLocation.fromJson(json['end_location']),
      startlocation: StartLocation.fromJson(json['start_location']),
    );
  }
}
