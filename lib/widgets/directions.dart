import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/widgets/widgets.dart';

class Directions extends StatelessWidget {
  final String route;
  final LatLng selectedLocation;
  Directions({this.route, this.selectedLocation});
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
                  Navigator.popAndPushNamed(context, NavigationRoutes.map);
                }
              }),
        ),
        body: BlocProvider(
          create: (context) => CurrentLocationBloc(),
          child: DirectionView(
            selectedLocation: selectedLocation,
          ),
        ),
      ),
    );
  }
}
