import 'package:equatable/equatable.dart';

abstract class CurrentLocationEvent extends Equatable {
  const CurrentLocationEvent();
}

class GetCurrentLocation extends CurrentLocationEvent {
  const GetCurrentLocation();

  @override
  // TODO: implement props
  List<Object> get props => [];
}
