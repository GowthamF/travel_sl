import 'package:flutter/material.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/widgets/widgets.dart';

class DirectionsMenu extends StatefulWidget {
  final List<Routes> drivingRoutes;
  final List<Routes> busRoutes;
  final List<Routes> trainRoutes;

  DirectionsMenu({this.drivingRoutes, this.busRoutes, this.trainRoutes});

  @override
  State<StatefulWidget> createState() {
    return _DirectionsMenu();
  }
}

class _DirectionsMenu extends State<DirectionsMenu> {
  String busDistance = '';
  String busDuration = '';
  String trainDistance = '';
  String trainDuration = '';
  String driveDistance = '';
  String driveDuration = '';
  bool hasBusRoute = false;
  bool hasTrainRoute = false;
  bool hasDrivingRoute = false;

  @override
  void initState() {
    super.initState();

    if (widget.busRoutes.isNotEmpty) {
      if (busDistance.isEmpty && busDuration.isEmpty) {
        busDistance =
            '${widget.busRoutes.first.getLegs.first.getDistance.getText}';
        busDuration =
            '${widget.busRoutes.first.getLegs.first.getDurations.getText}';
        hasBusRoute = true;
      }
    }

    if (widget.trainRoutes.isNotEmpty) {
      if (trainDuration.isEmpty && trainDistance.isEmpty) {
        trainDistance =
            '${widget.trainRoutes.first.getLegs.first.getDistance.getText}';
        trainDuration =
            '${widget.trainRoutes.first.getLegs.first.getDurations.getText}';
        hasTrainRoute = true;
      }
    }

    if (widget.drivingRoutes.isNotEmpty) {
      driveDistance =
          '${widget.drivingRoutes.first.getLegs.first.getDistance.getText}';
      driveDuration =
          '${widget.drivingRoutes.first.getLegs.first.getDurations.getText}';
      hasDrivingRoute = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 20.0,
      physics: AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: <Widget>[
        GridTile(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFeeeeee),
                border: Border.all(color: Colors.black45, width: 0.5)),
            child: FlatButton(
              onPressed: hasBusRoute
                  ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BusView()));
                    }
                  : null,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.directions_bus,
                            color: Color(0xFF80deea),
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Bus',
                            style: TextStyle(
                                fontSize: 25, color: Color(0xFF80deea)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          busDistance.isNotEmpty ? "LKR 45" : "",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5, right: 10, top: 20, bottom: 10),
                        child: Text(
                          busDuration,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          busDistance,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GridTile(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFeeeeee),
                border: Border.all(color: Colors.black45, width: 0.5)),
            child: FlatButton(
              onPressed: hasTrainRoute
                  ? () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TrainView()));
                    }
                  : null,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.directions_railway,
                            color: Color(0xFFe91e63),
                            size: 40,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Train',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFFe91e63),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          trainDistance.isNotEmpty ? "LKR 20" : "",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5, right: 10, top: 20, bottom: 10),
                        child: Text(
                          trainDuration,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          trainDistance,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GridTile(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFeeeeee),
                border: Border.all(color: Colors.black45, width: 0.5)),
            child: FlatButton(
              onPressed: null,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.local_taxi,
                            size: 40,
                            color: Color(0xFFff7043),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Taxi',
                            style: TextStyle(
                                fontSize: 25, color: Color(0xFFff7043)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5, right: 10, top: 20, bottom: 10),
                        child: Text(
                          '0 Mins',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          '0 Km',
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        GridTile(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFeeeeee),
                border: Border.all(color: Colors.black45, width: 0.5)),
            child: FlatButton(
              onPressed: hasDrivingRoute
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GMap(
                                    routeMode: TravelMode.Driving,
                                  )));
                    }
                  : null,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.directions_car,
                            size: 40,
                            color: Color(0xFF3949ab),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Drive',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFF3949ab),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5, right: 10, top: 20, bottom: 10),
                        child: Text(
                          driveDuration,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Text(
                          driveDistance,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
