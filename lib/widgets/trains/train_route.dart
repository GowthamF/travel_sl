import 'package:flutter/material.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class TrainRoute extends StatelessWidget {
  final TrainViewData _trainViewData = TrainViewData.getInstance();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (c, i) {
        return Divider(
          thickness: 1.5,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_trainViewData.trainData[index].routeName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainRouteView(
                  selectedTrain: _trainViewData.trainData[index],
                ),
              ),
            );
          },
        );
      },
      itemCount: _trainViewData.trainData.length,
    );
  }
}
