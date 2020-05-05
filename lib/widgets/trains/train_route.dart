import 'package:flutter/material.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class TrainRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TrainRoute();
  }
}

class _TrainRoute extends State<TrainRoute> {
  final TrainViewData _trainViewData = TrainViewData.getInstance();
  static List<TrainData> _trainList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _trainList = _trainViewData.trainData;
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
                  _trainList = _trainViewData.trainData
                      .where((f) =>
                          f.routeName
                              .toUpperCase()
                              .contains(value.trim().toUpperCase()) ||
                          f.route
                              .toUpperCase()
                              .contains(value.trim().toUpperCase()))
                      .toList();
                });
              } else {
                setState(() {
                  _trainList = _trainViewData.trainData;
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
              thickness: 1.5,
            );
          },
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_trainList[index].routeName),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainRouteView(
                      selectedTrain: _trainList[index],
                    ),
                  ),
                );
              },
            );
          },
          itemCount: _trainList.length,
        ))
      ],
    );
  }
}
