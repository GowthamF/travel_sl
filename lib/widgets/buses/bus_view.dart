import 'package:flutter/material.dart';
import 'package:travel_sl/models/models.dart';
import 'package:travel_sl/singletons/singletons.dart';
import 'package:travel_sl/widgets/widgets.dart';

class BusView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BusView();
  }
}

class _BusView extends State<BusView> {
  RoutesSingleTon _routesSingleTon = RoutesSingleTon.getInstance();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Bus'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.map),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GMap(
                                routeMode: TravelMode.Bus,
                              )));
                })
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Column(children: drawDirectionDetails()),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> drawDirectionDetails() {
    List<Widget> _paths = [];
    List<String> showingLocationName = [];
    Steps previousStep;
    String color;

    _routesSingleTon.busRoutes.first.getLegs.forEach(
      (l) => {
        for (var i = 0; i < l.getSteps.length; i++)
          {
            if (l.getSteps[i].travelMode == TravelMode.Walking)
              {
                previousStep = i == 0 ? l.getSteps[i] : l.getSteps[i - 1],
                if (i == 0)
                  {
                    showingLocationName = l.getStartAddress.split(','),
                    _paths.add(
                      PathTemplate(
                        instruction: 'Walk ${l.getSteps[i].distance.getText}',
                        isWalking: true,
                        locationName: showingLocationName.first,
                        subLocationName: showingLocationName[1],
                        showingIcon: Icon(Icons.directions_walk),
                        time: l.originDepatureTime.text,
                      ),
                    )
                  },
                if (i == l.getSteps.length - 1)
                  {
                    showingLocationName = l.getEndAddress.split(','),
                    _paths.add(
                      PathTemplate(
                        arrivalStopName:
                            previousStep.travelMode == TravelMode.Transit
                                ? previousStep.transitDetails.arrivalStopName
                                : '',
                        isLastIndex: true,
                        instruction: 'Walk ${l.getSteps[i].distance.getText}',
                        isWalking: true,
                        locationName: showingLocationName.first,
                        subLocationName: showingLocationName[1],
                        showingIcon: Icon(Icons.directions_walk),
                        arrivalStopTime: previousStep.travelMode ==
                                TravelMode.Transit
                            ? previousStep.transitDetails.arrivalStopTime.text
                            : '',
                        time: l.destinationArrivalTime.text,
                      ),
                    ),
                  }
                else if (previousStep.travelMode == TravelMode.Transit)
                  {
                    _paths.add(
                      PathTemplate(
                        showingIcon: Icon(Icons.directions_walk),
                        isWalking: true,
                        locationName:
                            previousStep.transitDetails.arrivalStopName,
                        instruction: 'Walk ${l.getSteps[i].distance.getText}',
                        time: previousStep.transitDetails.arrivalStopTime.text,
                      ),
                    )
                  }
              }
            else if (l.getSteps[i].travelMode == TravelMode.Transit)
              {
                color =
                    l.getSteps[i].transitDetails.color.replaceAll('#', '0xFF'),
                _paths.add(
                  PathTemplate(
                    isWalking: false,
                    locationName: l.getSteps[i].transitDetails.depatureStopName,
                    instruction:
                        '${l.getSteps[i].transitDetails.transitModeNumber} ${l.getSteps[i].transitDetails.transitModeName}',
                    subInstruction:
                        '${l.getSteps[i].durations.getText} (${l.getSteps[i].transitDetails.numStops} Stops)',
                    showingIcon: Icon(Icons.directions_bus),
                    color: Color(
                      int.parse(color),
                    ),
                    time: l.getSteps[i].transitDetails.destinationStopTime.text,
                  ),
                ),
                if (i == l.getSteps.length - 1)
                  {
                    showingLocationName = l.getEndAddress.split(','),
                    _paths.add(
                      PathTemplate(
                        arrivalStopName: showingLocationName.first,
                        isLastIndex: true,
                        locationName: showingLocationName.first,
                        subLocationName: showingLocationName[1],
                        showingIcon: null,
                        arrivalStopTime: l.destinationArrivalTime.text,
                        time: l.destinationArrivalTime.text,
                      ),
                    ),
                  }
              }
          },
      },
    );

    return _paths;
  }
}
