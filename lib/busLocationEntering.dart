import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusLocationEntering extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BusLocationEntering();
  }
}

class _BusLocationEntering extends State<BusLocationEntering> {
  static List<BusLocations> _currentBusLocation = [];
  TextEditingController _lateditingController;
  TextEditingController _longeditingController;
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _lateditingController = TextEditingController();
    _longeditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bus Location Entering'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text('$index'),
              title: Text(
                  '${_currentBusLocation[index].geoPoint.latitude}, ${_currentBusLocation[index].geoPoint.longitude}'),
            );
          },
          itemCount: _currentBusLocation.length,
        ),
        persistentFooterButtons: <Widget>[
          FlatButton(
            onPressed: () {
              try {
                databaseReference
                    .collection('busLocation')
                    .document('currentLocation')
                    .updateData(
                        {'location': _currentBusLocation.last.geoPoint});
              } catch (e) {
                print(e.toString());
              }
            },
            child: Text('UPDATE LOCATION'),
          )
        ],
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Text('Adding Bus Location'),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _lateditingController,
                        decoration: InputDecoration(hintText: 'Enter Latitude'),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            InputDecoration(hintText: 'Enter Longitude'),
                        controller: _longeditingController,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 100),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              _currentBusLocation.add(BusLocations(
                                  geoPoint: GeoPoint(6.948930, 79.856841),
                                  isSelected: false));
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('ADD BUS LOCATION'),
                        ))
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _lateditingController.dispose();
    super.dispose();
  }
}

class BusLocations {
  final GeoPoint geoPoint;
  bool isSelected;

  BusLocations({this.geoPoint, this.isSelected});
}
