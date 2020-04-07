import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
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
  final singleton.Location _location = singleton.Location.getInstance();
  final singleton.RoutesSingleTon _routeSingleTon =
      singleton.RoutesSingleTon.getInstance();
  @override
  Widget build(BuildContext context) {
    // RouteBloc routeBloc = BlocProvider.of<RouteBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
          ],
          child: common.GMap(widget.route),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.directions),
          tooltip: 'Directions',
          onPressed: () async {
            _routeSingleTon.routes.clear();
            await Navigator.pushNamed(context, NavigationRoutes.directions,
                arguments: NavigationRoutes.map);
            print('${_location.currentLocation}');
            _routeSingleTon.addLocation();
          },
        ),
      ),
    );
  }
}
