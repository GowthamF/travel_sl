import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/widgets/map/gmap.dart' as common;
import 'package:travel_sl/widgets/widgets.dart';

class GMap extends StatefulWidget {
  final String route;
  final TravelMode routeMode;
  GMap({this.route, this.routeMode});

  @override
  State<StatefulWidget> createState() {
    return _GMap();
  }
}

class _GMap extends State<GMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text('Map'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false);
                }),
          ),
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RouteBloc(),
              ),
              BlocProvider(
                create: (context) => CurrentAddressBloc(),
              ),
              BlocProvider(
                create: (context) => GetBusCurrentLocationBloc(),
              ),
            ],
            child: common.GMap(
              widget.route,
              routeMode: widget.routeMode,
            ),
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.all(50),
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              child: Icon(Icons.directions),
              tooltip: 'Directions',
              onPressed: () async {
                await Navigator.pushNamed(context, NavigationRoutes.directions,
                    arguments: NavigationRoutes.map);
              },
            ),
          ),
        ));
  }
}
