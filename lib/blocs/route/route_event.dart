import 'package:equatable/equatable.dart';
import 'package:geocoder/geocoder.dart';
import 'package:meta/meta.dart';
import 'package:travel_sl/blocs/blocs.dart';

abstract class RouteEvent extends Equatable {
  const RouteEvent();
}

class GetRoute extends RouteEvent {
  final String origin;
  final String destination;

  const GetRoute({@required this.origin, this.destination})
      : assert(origin != null && destination != null);

  @override
  // TODO: implement props
  List<Object> get props => [origin, destination];
}
