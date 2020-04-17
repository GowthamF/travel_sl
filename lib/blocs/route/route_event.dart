import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travel_sl/models/models.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class GetRoute extends RouteEvent {
  final String origin;
  final String destination;
  final String mode;
  final TravelMode travelMode;

  const GetRoute(
      {@required this.origin, this.destination, this.mode, this.travelMode})
      : assert(origin != null && destination != null);

  @override
  List<Object> get props => [origin, destination, mode];
}
