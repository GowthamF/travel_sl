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
    return SafeArea(
      child: Scaffold(
        body: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CurrentLocationBloc()),
              BlocProvider(create: (context) => PlaceAutoSuggestBloc()),
              BlocProvider(create: (context) => RouteBloc()),
            ],
            child: DirectionsFrom(
              isEditMode: false,
            )),
      ),
    );
  }
}
