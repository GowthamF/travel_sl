import 'package:equatable/equatable.dart';
import 'package:geocoder/model.dart';
import 'package:travel_sl/models/models.dart';

abstract class CurrentAddressState extends Equatable {
  const CurrentAddressState();

  @override
  // TODO: implement props
  List<MarkerAddress> get props => [];
}

class CurrentAddressEmpty extends CurrentAddressState {}

class CurrentAddressLoading extends CurrentAddressState {}

class CurrentAddressLoaded extends CurrentAddressState {
  final List<MarkerAddress> address;

  const CurrentAddressLoaded({this.address}) : assert(address != null);

  @override
  // TODO: implement props
  List<MarkerAddress> get props => address;
}

class CurrentAddressError extends CurrentAddressState {}
