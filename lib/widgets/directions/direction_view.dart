import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/widgets.dart';

class DirectionView extends StatefulWidget {
  DirectionView();

  @override
  State<StatefulWidget> createState() {
    return _DirectionView();
  }
}

class _DirectionView extends State<DirectionView> {
  singleton.Location _location = singleton.Location.getInstance();
  singleton.RoutesSingleTon _routesSingleTon =
      singleton.RoutesSingleTon.getInstance();
  singleton.PlacesSingleTon _placesSingleTon =
      singleton.PlacesSingleTon.getInstance();
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
    routeBloc = BlocProvider.of<RouteBloc>(context);
    _routesSingleTon.addCurrentLocation = addCurrentLocation;
    getDirections(_placesSingleTon.selectedOrigin.location,
        _placesSingleTon.selectedDestination.location);
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
            actions: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GMap(
                                routeMode: TravelMode.Driving,
                              )));
                },
                child: Text('Map'),
              )
            ],
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
                                    _placesSingleTon.selectedOrigin.showName,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          IconButton(
                            tooltip: 'Edit',
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                          create: (context) =>
                                              CurrentLocationBloc()),
                                      BlocProvider(
                                          create: (context) =>
                                              PlaceAutoSuggestBloc()),
                                      BlocProvider(
                                          create: (context) => RouteBloc()),
                                    ],
                                    child: DirectionsFrom(
                                      isEditMode: true,
                                    ),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.only(top: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
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
                                    _placesSingleTon
                                        .selectedDestination.showName,
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          IconButton(
                            tooltip: 'Edit',
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => PlaceAutoSuggestBloc(),
                                    child: DirectionsTo(),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.only(top: 20),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: BlocBuilder<RouteBloc, RouteState>(
                    builder: (context, state) {
                      if (state is RouteLoaded) {
                        _routesSingleTon.busRoutes = state.busRoutes;
                        _routesSingleTon.drivingRoutes = state.drivingRoutes;
                        _routesSingleTon.trainRoutes = state.trainRoutes;
                        return DirectionsMenu(
                          drivingRoutes: state.drivingRoutes,
                          busRoutes: state.busRoutes,
                          trainRoutes: state.trainRoutes,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
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
    _routesSingleTon.busRoutes.clear();
    _routesSingleTon.trainRoutes.clear();
  }

  addCurrentLocation() {
    if (mounted) {
      // currentLocationBloc.add(GetCurrentLocation());
    }
  }
}
