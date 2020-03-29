import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

abstract class CurrentLocationState extends Equatable {
  const CurrentLocationState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CurrentLocationEmpty extends CurrentLocationState {}

class CurrentLocationLoading extends CurrentLocationState {}

class CurrentLocationLoaded extends CurrentLocationState {
  final Position position;

  const CurrentLocationLoaded({this.position}) : assert(position != null);

  @override
  // TODO: implement props
  List<Object> get props => [position];
}

class CurrentLocationError extends CurrentLocationState {}
