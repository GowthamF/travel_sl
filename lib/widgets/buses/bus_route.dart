import 'package:flutter/material.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class BusRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BusRoute();
  }
}

class _BusRoute extends State<BusRoute> {
  final BusViewData _busViewData = BusViewData.getInstance();
  static List<BusData> _busList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _busList = _busViewData.busData;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          child: TextFormField(
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _busList = _busViewData.busData
                      .where((f) =>
                          f.routeName
                              .toUpperCase()
                              .contains(value.trim().toUpperCase()) ||
                          f.busNumber.contains(value.trim()) ||
                          f.route.contains(value.trim()))
                      .toList();
                });
              } else {
                setState(() {
                  _busList = _busViewData.busData;
                });
              }
            },
            style: TextStyle(fontSize: 15),
            autovalidate: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(fontSize: 15, color: Colors.white),
              hintText: 'Search',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
            ),
          ),
        ),
        Expanded(
            child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (c, i) {
            return Divider(
              thickness: 1,
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_busList[index].busNumber),
              subtitle: Text(_busList[index].routeName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusRouteView(
                      selectedBus: _busList[index],
                    ),
                  ),
                );
              },
            );
          },
          itemCount: _busList.length,
        ))
      ],
    );
  }
}
