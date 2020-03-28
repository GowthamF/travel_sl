import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:travel_sl/models/models.dart';

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteEmpty extends RouteState {}

class RouteLoading extends RouteState {}

class RouteLoaded extends RouteState {
  final List<Routes> routes;

  const RouteLoaded({this.routes}) : assert(routes != null);

  @override
  // TODO: implement props
  List<Object> get props => [routes];
}

class RouteError extends RouteState {}
