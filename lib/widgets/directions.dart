import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class Directions extends StatelessWidget {
  final String route;
  final LatLng selectedLocation;
  Directions({this.route, this.selectedLocation});
  RoutesSingleTon _routesSingleTon = RoutesSingleTon.getInstance();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Directions'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (route == NavigationRoutes.map) {
                Navigator.pop(context);
              } else {
                Navigator.popAndPushNamed(
                  context,
                  NavigationRoutes.map,
                );
              }
            },
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  _routesSingleTon.addCurrentLocation();
                })
          ],
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CurrentLocationBloc()),
            BlocProvider(create: (context) => PlaceAutoSuggestBloc()),
            BlocProvider(create: (context) => RouteBloc()),
          ],
          child: DirectionView(
            selectedLocation: selectedLocation,
          ),
        ),
      ),
    );
  }
}
