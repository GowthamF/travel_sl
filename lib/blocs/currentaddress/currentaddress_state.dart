import 'package:equatable/equatable.dart';
import 'package:travel_sl/models/models.dart';

abstract class CurrentAddressState extends Equatable {
  const CurrentAddressState();

  @override
  List<MarkerAddress> get props => [];
}

class CurrentAddressEmpty extends CurrentAddressState {}

class CurrentAddressLoading extends CurrentAddressState {}

class CurrentAddressLoaded extends CurrentAddressState {
  final List<MarkerAddress> address;

  const CurrentAddressLoaded({this.address}) : assert(address != null);

  @override
  List<MarkerAddress> get props => address;
}

class CurrentAddressError extends CurrentAddressState {}
