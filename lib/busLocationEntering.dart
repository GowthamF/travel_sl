import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusLocationEntering extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BusLocationEntering();
  }
}

class _BusLocationEntering extends State<BusLocationEntering> {
  final databaseReference = Firestore.instance;
  final geolocator = Geolocator();
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.9345573, 79.8512368),
    zoom: 15,
  );
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    _initCurrentLocation();

    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.medium, distanceFilter: 10);
    geolocator.getPositionStream(locationOptions).listen((position) {
      addToDB(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Bus Location Entering'),
          ),
          body: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            trafficEnabled: true,
            initialCameraPosition: _kGooglePlex,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) async {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(_kGooglePlex),
                );
              }
            },
          )),
    );
  }

  void _initCurrentLocation() {
    geolocator
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).then((position) {
        if (mounted) {
          addToDB(position);
          setState(
            () {
              _kGooglePlex = CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 15);

              _controller.future.then(
                (onValue) {
                  onValue
                      .moveCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
                },
              );
            },
          );
        }
      }).catchError((e) {
        print(e);
      });
  }

  void addToDB(Position position) {
    try {
      databaseReference
          .collection('busLocation')
          .document('currentLocation')
          .updateData(
              {'location': GeoPoint(position.latitude, position.longitude)});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
