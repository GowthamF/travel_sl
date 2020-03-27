import 'package:travel_sl/bloc/models/directions/legs.dart';
import 'package:travel_sl/bloc/models/directions/polyline.dart';

class Routes {
  final List<Legs> legs;
  final PolyLine polyLine;

  Routes({this.legs, this.polyLine});

  List<Legs> get getLegs => legs;
  PolyLine get getPolyLines => polyLine;

  factory Routes.fromJson(Map<String, dynamic> json) {
    dynamic _legs = json['legs'];
    dynamic _polyLine = json['overview_polyline'];
    List<Legs> legs = [];

    for (var i = 0; i < _legs.length; i++) {
      legs.add(Legs.fromJson(_legs[i]));
    }

    PolyLine polyLine = PolyLine.fromJson(_polyLine);

    return Routes(legs: legs, polyLine: polyLine);
  }
}
