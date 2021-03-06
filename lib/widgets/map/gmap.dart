import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/places/placesview.dart';

class GMap extends StatefulWidget {
  final String route;
  final TravelMode routeMode;

  GMap(this.route, {this.routeMode});

  @override
  State<StatefulWidget> createState() {
    return _GMap();
  }
}

class _GMap extends State<GMap> {
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> latlng = List();
  final Set<Marker> _markers = {};
  bool isOriginAdded = true;
  final Set<Polyline> _polylines = {};
  CurrentAddressBloc currentAddressBloc;
  // static Position _currentPosition;
  static String address = 'adadadas';
  singleton.RoutesSingleTon _routesSingleTon =
      singleton.RoutesSingleTon.getInstance();
  singleton.Location _location = singleton.Location.getInstance();
  GeoPoint currentBusLocation;
  GetBusCurrentLocationBloc getBusCurrentLocationBloc;

  // final BitmapDescriptor busMarker = BitmapDescriptor.fromAssetImage(configuration, assetName)

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.9345573, 79.8512368),
    zoom: 15,
  );

  _GMap() {
    _routesSingleTon.addLocation = addDirection;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(markerId: MarkerId('SelectedLocation')));
    _initCurrentLocation();
    currentAddressBloc = BlocProvider.of<CurrentAddressBloc>(context);
    getBusCurrentLocationBloc =
        BlocProvider.of<GetBusCurrentLocationBloc>(context);
    if (widget.routeMode == TravelMode.Bus) {
      getBusCurrentLocationBloc.add(StartGetBusCurrentLocation());
    }

    addDirection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RouteBloc, RouteState>(
          listener: (context, state) {
            if (state is RouteLoaded) {
              getPolyLines(state.drivingRoutes);
            }
          },
        ),
        BlocListener<CurrentAddressBloc, CurrentAddressState>(
          listener: (context, state) {
            if (state is CurrentAddressLoaded) {
              addLocationMarker(state.props.first.locationLatLng,
                  state.props.first.addressLine, state.props.first.displayName);
            }
          },
        ),
        BlocListener<GetBusCurrentLocationBloc, GetBusCurrentLocationState>(
          listener: (context, state) {
            if (state is GetBusCurrentLocationLoaded) {
              LatLng currentBusLocation =
                  LatLng(state.geoPoint.latitude, state.geoPoint.longitude);
              addBusLocationMarker(currentBusLocation);
            }
          },
        )
      ],
      child: GoogleMap(
        buildingsEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        trafficEnabled: true,
        onTap: (latlng) {
          if (widget.routeMode == null) {
            currentAddressBloc.add(
              GetAddressInfo(
                coordinates: Coordinates(latlng.latitude, latlng.longitude),
              ),
            );
          }
        },
        markers: _markers,
        polylines: _polylines,
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
      ),
    );
  }

  void addLocationMarker(
      LatLng selectedPosition, String address, String displayName) {
    setState(() {
      var marker = _markers.first;
      _markers.removeWhere(
        (f) => f.markerId == marker.markerId,
      );
      _markers.add(Marker(
        markerId: marker.markerId,
        position: selectedPosition,
        infoWindow: InfoWindow(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlacesView(
                  selectedLocation: selectedPosition,
                  address: displayName,
                ),
              ),
            );
          },
          title: address,
        ),
        icon: isOriginAdded
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ));
    });
  }

  void addBusLocationMarker(LatLng location) async {
    final bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(15, 15)), 'assets/images/aaaa.png');
    setState(() {
      _markers.removeWhere(
        (f) => f.markerId == MarkerId('BusLocation'),
      );
      _markers.add(Marker(
        markerId: MarkerId('BusLocation'),
        position: location,
        icon: bitmapIcon,
      ));
    });
  }

  List<LatLng> polylineCoordinates = [];
  void getPolyLines(List<Routes> routes) {
    PolylinePoints polylinePoints = PolylinePoints();

    List<PointLatLng> results = [];

    if (widget.routeMode == TravelMode.Driving) {
      for (var i = 0; i < routes.length; i++) {
        Color _color = i == 0 ? Colors.blue : Colors.black38;
        results = polylinePoints.decodePolyline(routes[i].getPolyLines.points);

        PolylineId _polyLineId = PolylineId('route_$i');
        Polyline polyline = Polyline(
            consumeTapEvents: true,
            onTap: () {
              removeSelectedPolyline(_polyLineId);
            },
            zIndex: i == 0 ? 1 : 0,
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

    if (widget.routeMode == TravelMode.Bus ||
        widget.routeMode == TravelMode.Train) {
      for (var i = 0; i < routes.length; i++) {
        Color _colorWalk = i == 0 ? Colors.blue : Colors.black12;

        for (var j = 0; j < routes[i].getLegs.length; j++) {
          for (var k = 0; k < routes[i].getLegs[j].getSteps.length; k++) {
            if (routes[i].getLegs[j].getSteps[k].travelMode ==
                TravelMode.Walking) {
              results = polylinePoints.decodePolyline(
                  routes[i].getLegs[j].getSteps[k].polyLine.getPoints);

              PolylineId _polyLineId = PolylineId('step_$k');
              Polyline polyline = Polyline(
                  patterns: [PatternItem.dot],
                  jointType: JointType.round,
                  consumeTapEvents: true,
                  zIndex: 5,
                  polylineId: _polyLineId,
                  color: _colorWalk,
                  points: _convertToLatLng(results));
              setState(
                () {
                  _polylines.add(polyline);
                },
              );
            } else if (routes[i].getLegs[j].getSteps[k].travelMode ==
                TravelMode.Transit) {
              results = polylinePoints.decodePolyline(
                  routes[i].getLegs[j].getSteps[k].polyLine.getPoints);
              PolylineId _polyLineId = PolylineId('step_$k');
              var colorValue = routes[i]
                  .getLegs[j]
                  .getSteps[k]
                  .transitDetails
                  .color
                  .replaceAll('#', '0xFF');
              var _colorRoute = Color(int.parse(colorValue));
              Polyline polyline = Polyline(
                  jointType: JointType.round,
                  consumeTapEvents: true,
                  zIndex: 5,
                  polylineId: _polyLineId,
                  color: _colorRoute,
                  points: _convertToLatLng(results));
              setState(
                () {
                  _polylines.add(polyline);
                },
              );
            }
          }
          break;
        }
        break;
      }
    }

    _kGooglePlex = CameraPosition(
        target: LatLng(routes.first.legs.first.getStartLocation.lat,
            routes.first.legs.first.getStartLocation.lng),
        zoom: 15);

    _controller.future.then(
      (onValue) {
        onValue.moveCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      },
    );
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
            color: Colors.black38,
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
          _location.currentLocation = position;
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

  void addDirection() {
    if (widget.routeMode == TravelMode.Driving) {
      if (_routesSingleTon.drivingRoutes.isNotEmpty) {
        getPolyLines(_routesSingleTon.drivingRoutes);
        addRoutesMarker(_routesSingleTon.drivingRoutes);
      }
    } else if (widget.routeMode == TravelMode.Bus) {
      if (_routesSingleTon.busRoutes.isNotEmpty) {
        getPolyLines(_routesSingleTon.busRoutes);
        addRoutesMarker(_routesSingleTon.busRoutes);
      }
    } else if (widget.routeMode == TravelMode.Train) {
      if (_routesSingleTon.trainRoutes.isNotEmpty) {
        getPolyLines(_routesSingleTon.trainRoutes);
        addRoutesMarker(_routesSingleTon.trainRoutes);
      }
    }

    if (_routesSingleTon.drivingRoutes.isEmpty) {
      setState(() {
        _polylines.clear();
        _initCurrentLocation();
      });
    }
  }

  void addRoutesMarker(List<Routes> routes) {
    routes.forEach((r) {
      r.getLegs.forEach((l) {
        _markers.add(Marker(
          markerId: MarkerId(l.startaddress),
          position: LatLng(l.startlocation.lat, l.startlocation.lng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ));
        _markers.add(Marker(
          markerId: MarkerId(l.endaddress),
          position: LatLng(l.endlocation.lat, l.endlocation.lng),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        ));
      });
    });
  }
}
