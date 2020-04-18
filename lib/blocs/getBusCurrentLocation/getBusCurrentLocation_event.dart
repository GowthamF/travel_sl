import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class GetBusCurrentLocationEvent extends Equatable {
  const GetBusCurrentLocationEvent();

  @override
  List<Object> get props => [];
}

class StartGetBusCurrentLocation extends GetBusCurrentLocationEvent {}

class GetBusCurrentLocation extends GetBusCurrentLocationEvent {
  final GeoPoint geoPoint;
  const GetBusCurrentLocation({this.geoPoint});

  @override
  List<Object> get props => [geoPoint];
}
