import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/repositories/autosuggest_api_client.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/widgets.dart';

class DirectionView extends StatefulWidget {
  final LatLng selectedLocation;

  DirectionView({this.selectedLocation});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DirectionView();
  }
}

class _DirectionView extends State<DirectionView> {
  singleton.Location _location = singleton.Location.getInstance();
  singleton.RoutesSingleTon _routesSingleTon =
      singleton.RoutesSingleTon.getInstance();
  TextEditingController currentLocationController;
  TextEditingController destinationController;
  RouteBloc routeBloc;
  List<AutoSuggestPlace> autoSuggestPlaces = [];
  GlobalKey<AutoCompleteTextFieldState<AutoSuggestPlace>> originKey =
      GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<AutoSuggestPlace>> destinationKey =
      GlobalKey();
  String originPlaceId = '';
  String destinationPlaceId = '';
  static bool isCurrentLocationAvailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    currentLocationController = TextEditingController();
    destinationController = TextEditingController();
    routeBloc = BlocProvider.of<RouteBloc>(context);
    if (widget.selectedLocation == null) {
    } else {
      currentLocationController.text = '${widget.selectedLocation}';
    }

    _routesSingleTon.transitRoutes.clear();
    _routesSingleTon.drivingRoutes.clear();
    _routesSingleTon.addCurrentLocation = addCurrentLocation;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Directions'),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.blue)),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 25, bottom: 20),
                                  child: Text(
                                    'Current Location',
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          IconButton(
                            tooltip: 'Edit',
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                            padding: EdgeInsets.only(top: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.blue)),
                  child: Wrap(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 25, bottom: 20),
                                  child: Text(
                                    'Current Location',
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          IconButton(
                            tooltip: 'Edit',
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                            padding: EdgeInsets.only(top: 20),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  void getDirections(String origin, String destination) {
    routeBloc.add(
        GetRoute(origin: origin, destination: destination, mode: 'transit'));
  }

  void clearRoutes() {
    _routesSingleTon.drivingRoutes.clear();
    _routesSingleTon.transitRoutes.clear();
  }

  addCurrentLocation() {
    if (mounted) {
      // currentLocationBloc.add(GetCurrentLocation());
    }
  }
}
