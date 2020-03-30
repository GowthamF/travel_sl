import 'package:equatable/equatable.dart';
import 'package:geocoder/geocoder.dart';

abstract class CurrentAddressEvent extends Equatable {
  const CurrentAddressEvent();
}

class GetAddressInfo extends CurrentAddressEvent {
  final Coordinates coordinates;

  const GetAddressInfo({this.coordinates}) : assert(coordinates != null);

  @override
  List<Object> get props => [coordinates];
}
