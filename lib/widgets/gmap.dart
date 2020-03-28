import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_sl/blocs/blocs.dart';
import 'package:travel_sl/repositories/repositories.dart';
import 'package:travel_sl/widgets/map/gmap.dart' as common;
import 'package:http/http.dart' as http;

class GMap extends StatelessWidget {
  final String route;

  final RouteRepository routeRepository = RouteRepository(
    routeApiClient: RouteApiClient(
      httpClient: http.Client(),
    ),
  );

  GMap(this.route);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Map'),
          ),
          body: BlocProvider(
            create: (context) => RouteBloc(routeRepository: routeRepository),
            child: common.GMap(route),
          )),
    );
  }
}
