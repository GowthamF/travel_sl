import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/singletons/singletons.dart';

class DirectionView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DirectionView();
  }
}

class _DirectionView extends State<DirectionView> {
  CurrentLocationBloc currentLocationBloc;
  Location _location = Location.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentLocationBloc = BlocProvider.of<CurrentLocationBloc>(context);
    currentLocationBloc.add(GetCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentLocationBloc, CurrentLocationState>(
      builder: (context, state) {
        if (state is CurrentLocationLoaded) {
          _location.currentLocation = state.position;
          return Text('${state.position}');
        }
        if (state is CurrentLocationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
      listener: (context, state) {
        if (state is CurrentLocationLoaded) {}
      },
    );
  }
}
