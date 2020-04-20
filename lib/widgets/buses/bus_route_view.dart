import 'package:flutter/material.dart';
import 'package:travel_sl/singletons/singletons.dart';

class BusRouteView extends StatelessWidget {
  final BusData selectedBus;

  BusRouteView({this.selectedBus});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Bus Number - ${selectedBus.busNumber}'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(top: 25, left: 25),
              title: Text('ROUTE NAME'),
              subtitle: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(selectedBus.routeName)),
            ),
            Divider(
              thickness: 1.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(top: 50, left: 25),
              title: Text('ROUTE'),
              subtitle: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(selectedBus.route)),
            ),
            Divider(
              thickness: 1.5,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(top: 75, left: 25),
              title: Text('ACTIONS'),
              subtitle: Container(
                  padding: EdgeInsets.only(top: 15, right: 25),
                  child: RaisedButton(
                      onPressed: null, child: Text('Show This Route'))),
            ),
          ],
        ),
      ),
    ));
  }
}
