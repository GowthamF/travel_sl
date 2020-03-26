import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/bloc/api_provider/route_api_provider.dart';
import 'package:travel_sl/bloc/bloc.dart';
import 'package:travel_sl/bloc/blocs/route_bloc.dart';

class GoggleMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GMap();
  }
}

class _GMap extends State<GoggleMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> latlng = List();
  final Set<Marker> _markers = {};
  bool isOriginAdded = true;
  final Set<Polyline> _polylines = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.9345573, 79.8512368),
    zoom: 15,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _polyline.add(Polyline(polylineId: PolylineId('1'), points: latlng));
    // TODO: implement build
    return GoogleMap(
      trafficEnabled: true,
      onTap: (latlng) {
        if (isOriginAdded) {
          addLocationMarker(latlng, 'origin');
          isOriginAdded = false;
        } else {
          addLocationMarker(latlng, 'destination');
          isOriginAdded = true;
        }
      },
      markers: _markers,
      polylines: _polylines,
      initialCameraPosition: _kGooglePlex,
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  void addLocationMarker(LatLng selectedPosition, String location) async {
    var results = await Geocoder.local.findAddressesFromCoordinates(
        new Coordinates(selectedPosition.latitude, selectedPosition.longitude));

    if (location == 'origin') {
      _markers.clear();
      _polylines.clear();
    }

    setState(
      () {
        _markers.add(
          Marker(
            markerId: MarkerId(location),
            position: selectedPosition,
            infoWindow: InfoWindow(
              title: results.first.addressLine,
            ),
            icon: isOriginAdded
                ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue)
                : BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueViolet),
          ),
        );
      },
    );

    if (location == 'destination') {
      dynamic startLocation =
          '${_markers.first.position.latitude},${_markers.first.position.longitude}';
      dynamic endLocation =
          '${selectedPosition.latitude},${selectedPosition.longitude}';

      // dynamic startLocation = '6.9125703,79.8523593';
      // dynamic endLocation = '6.8841101,79.8584285';
      await routeBloc.getRoute(startLocation, endLocation);

      routeBloc.getRoutes.listen((onData) {
        getPolyLines(onData);
      });
    }
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyLines(List<Routes> routes) {
    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> results = [];

    for (var i = 0; i < routes.length; i++) {
      Color _color = i == 0 ? Colors.blue : Colors.red;
      results = polylinePoints.decodePolyline(routes[i].getPolyLines.points);
      PolylineId _polyLineId = PolylineId('route_$i');
      Polyline polyline = Polyline(
          consumeTapEvents: true,
          onTap: () {
            removeSelectedPolyline(_polyLineId);
          },
          zIndex: i == 0 ? 5 : 0,
          polylineId: _polyLineId,
          color: _color,
          points: _convertToLatLng(results));
      setState(
        () {
          _polylines.add(polyline);
        },
      );
    }
  }

  List<LatLng> _convertToLatLng(List<PointLatLng> points) {
    List<LatLng> polylineCoordinates = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      polylineCoordinates.add(LatLng(points[i].latitude, points[i].longitude));
    }

    return polylineCoordinates;
  }

  void removeSelectedPolyline(PolylineId polyLineId) {
    var selectedPolyline =
        _polylines.firstWhere((f) => f.polylineId == polyLineId);
    var notSelectedPolyline =
        _polylines.where((f) => f.polylineId != polyLineId).toList();

    var newNotSelectedPolylines = notSelectedPolyline
        .map((f) => Polyline(
            polylineId: f.polylineId,
            consumeTapEvents: true,
            color: Colors.red,
            points: f.points,
            onTap: f.onTap,
            zIndex: 0))
        .toList();

    var newPolyline = Polyline(
        consumeTapEvents: true,
        polylineId: selectedPolyline.polylineId,
        color: Colors.blue,
        points: selectedPolyline.points,
        onTap: selectedPolyline.onTap,
        zIndex: 5);
    _polylines.removeWhere((f) => f.polylineId == selectedPolyline.polylineId);
    _polylines.removeAll(notSelectedPolyline);

    setState(() {
      _polylines.add(newPolyline);
      _polylines.addAll(newNotSelectedPolylines);
    });
  }
}
