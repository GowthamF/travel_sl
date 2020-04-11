import 'package:equatable/equatable.dart';
import 'package:travel_sl/models/models.dart';

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteEmpty extends RouteState {}

class RouteLoading extends RouteState {}

class RouteLoaded extends RouteState {
  final List<Routes> drivingRoutes;
  final List<Routes> busRoutes;
  final List<Routes> trainRoutes;

  const RouteLoaded({this.drivingRoutes, this.busRoutes, this.trainRoutes})
      : assert(drivingRoutes != null);

  @override
  // TODO: implement props
  List<Object> get props => [drivingRoutes];
}

class RouteError extends RouteState {}
