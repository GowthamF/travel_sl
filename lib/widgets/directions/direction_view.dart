import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/singletons/singletons.dart';

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
  CurrentLocationBloc currentLocationBloc;
  Location _location = Location.getInstance();
  TextEditingController currentLocationController;
  TextEditingController destinationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocationController = TextEditingController();
    destinationController = TextEditingController();
    if (widget.selectedLocation == null) {
      currentLocationBloc = BlocProvider.of<CurrentLocationBloc>(context);
      currentLocationBloc.add(GetCurrentLocation());
    } else {
      currentLocationController.text = '${widget.selectedLocation}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentLocationBloc, CurrentLocationState>(
      listener: (context, state) {
        if (state is CurrentLocationLoaded) {
          currentLocationController.text = '${state.position}';
        }
      },
      child: BlocBuilder<CurrentLocationBloc, CurrentLocationState>(
        builder: (context, state) {
          if (state is CurrentLocationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: <Widget>[
              Form(
                child: TextFormField(
                  controller: currentLocationController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
