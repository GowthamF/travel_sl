import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/controllers/controllers.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/widgets/widgets.dart';

class GMap extends StatefulWidget {
  final String route;
  final MapController controller;

  GMap(this.route, this.controller);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GMap(controller);
  }
}

class _GMap extends State<GMap> with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> latlng = List();
  final Set<Marker> _markers = {};
  bool isOriginAdded = true;
  final Set<Polyline> _polylines = {};
  RouteBloc routeBloc;
  // static Position _currentPosition;

  StreamSubscription<Position> positionStream;

  // final BitmapDescriptor busMarker = BitmapDescriptor.fromAssetImage(configuration, assetName)

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.9345573, 79.8512368),
    zoom: 15,
  );

  _GMap(MapController controller) {
    controller.addLocation = addDirection;
  }

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    routeBloc = BlocProvider.of<RouteBloc>(context);
    return BlocConsumer<RouteBloc, RouteState>(builder: (context, state) {
      return GoogleMap(
        myLocationEnabled: true,
        trafficEnabled: true,
        onTap: (latlng) {
          if (widget.route != NavigationRoutes.home) {
            if (isOriginAdded) {
              addLocationMarker(latlng, 'origin');
              isOriginAdded = false;
            } else {
              addLocationMarker(latlng, 'destination');
              isOriginAdded = true;
            }
          }
        },
        markers: _markers,
        polylines: _polylines,
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
            controller
                .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
          }
          //
        },
      );
    }, listener: (context, state) {
      if (state is RouteLoaded) {
        getPolyLines(state.routes);
      }
    });
  }

  void addLocationMarker(LatLng selectedPosition, String location) async {
    var results = await Geocoder.local.findAddressesFromCoordinates(
        new Coordinates(selectedPosition.latitude, selectedPosition.longitude));

    if (location == 'origin') {
      _markers.clear();
      _polylines.clear();
    }

    if (location == 'destination') {
      dynamic startLocation =
          '${_markers.first.position.latitude},${_markers.first.position.longitude}';
      dynamic endLocation =
          '${selectedPosition.latitude},${selectedPosition.longitude}';

      // dynamic startLocation = '6.9125703,79.8523593';
      // dynamic endLocation = '6.8841101,79.8584285';

      routeBloc.add(GetRoute(origin: startLocation, destination: endLocation));
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

  void addBusStations(List<BusStations> busStationsList) {
    setState(
      () {
        busStationsList.forEach((f) => {
              _markers.add(
                Marker(
                    markerId: MarkerId(f.getPlaceId),
                    position: LatLng(f.getGeometry.location.getLat,
                        f.getGeometry.location.getLng),
                    infoWindow: InfoWindow(title: f.getPlaceName),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)),
              )
            });
      },
    );
  }

  void addTrainStations(List<TrainStations> trainStationsList) {
    setState(
      () {
        trainStationsList.forEach((f) => {
              _markers.add(
                Marker(
                    markerId: MarkerId(f.getPlaceId),
                    position: LatLng(f.getGeometry.location.getLat,
                        f.getGeometry.location.getLng),
                    infoWindow: InfoWindow(title: f.getPlaceName),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueOrange)),
              )
            });
      },
    );
  }

  _initCurrentLocation() {
    Geolocator()
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      ).then((position) {
        if (mounted) {
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
        //
      });
  }

  addDirection() {
    print('Directions');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
