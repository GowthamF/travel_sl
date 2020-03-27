import 'package:flutter/material.dart';
import 'package:travel_sl/map/gmap.dart' as common;

class GMap extends StatelessWidget {
  final String route;

  GMap(this.route);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: common.GMap(route),
      ),
    );
  }
}
