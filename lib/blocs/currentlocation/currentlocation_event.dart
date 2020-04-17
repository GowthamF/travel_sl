import 'package:equatable/equatable.dart';

abstract class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();
}

class GetCurrentLocation extends CurrentLocationEvent {
  const GetCurrentLocation();

  @override
  List<Object> get props => [];
}
