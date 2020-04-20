import 'package:flutter/material.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class BusRoute extends StatelessWidget {
  final BusViewData _busViewData = BusViewData.getInstance();

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
          title: Text(_busViewData.busData[index].busNumber),
          subtitle: Text(_busViewData.busData[index].routeName),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusRouteView(
                  selectedBus: _busViewData.busData[index],
                ),
              ),
            );
          },
        );
      },
      itemCount: _busViewData.busData.length,
    );
  }
}
