import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
