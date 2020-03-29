import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/controllers/controllers.dart';
import 'package:travel_sl/singletons/singletons.dart' as singleton;
import 'package:travel_sl/widgets/map/gmap.dart' as common;
import 'package:travel_sl/widgets/widgets.dart';

class GMap extends StatefulWidget {
  final String route;
  // final
  //  = RouteRepository(
  //   routeApiClient: RouteApiClient(
  //     httpClient: http.Client(),
  //   ),
  // );

  GMap(this.route);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GMap();
  }
}

class _GMap extends State<GMap> {
  MapController controller = MapController();
  final singleton.Location _location = singleton.Location.getInstance();
  @override
  Widget build(BuildContext context) {
    // RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: BlocProvider(
          create: (context) => RouteBloc(),
          child: common.GMap(widget.route, controller),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.directions),
            tooltip: 'Directions',
            onPressed: () async {
              await Navigator.pushNamed(context, NavigationRoutes.directions,
                  arguments: NavigationRoutes.map);
              print('${_location.currentLocation}');
              controller.addLocation();
            }),
      ),
    );
  }
}
