import 'package:flutter/material.dart';
import 'package:travel_sl/widgets/widgets.dart';

class Trains extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Trains'),
        ),
        body: TrainRoute(),
      ),
    );
  }
}
