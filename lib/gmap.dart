import 'package:flutter/material.dart';
import 'package:travel_sl/map/gmap.dart';

class GMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        body: GoggleMap(),
      ),
    );
  }
}
