import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class GetBusCurrentLocationState extends Equatable {
  const GetBusCurrentLocationState();

  @override
  List<Object> get props => [];
}

class GetBusCurrentLocationEmpty extends GetBusCurrentLocationState {}

class GetBusCurrentLocationLoading extends GetBusCurrentLocationState {}

class GetBusCurrentLocationLoaded extends GetBusCurrentLocationState {
  final GeoPoint geoPoint;

  const GetBusCurrentLocationLoaded({this.geoPoint});

  @override
  List<Object> get props => [geoPoint];
}

class GetBusCurrentLocationError extends GetBusCurrentLocationState {}
