import 'package:flutter/material.dart';
import 'package:travel_sl/widgets/widgets.dart';

class PathTemplate extends StatelessWidget {
  final bool isLastIndex;
  final bool isWalking;
  final String locationName;
  final String instruction;
  final String subLocationName;
  final String subInstruction;
  final String arrivalStopName;
  final Icon showingIcon;

  PathTemplate(
      {this.isLastIndex = false,
      this.isWalking = true,
      this.locationName = '',
      this.instruction = '',
      this.subInstruction = '',
      this.subLocationName = '',
      this.arrivalStopName = '',
      this.showingIcon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      alignment: Alignment.topLeft,
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
          child: Container(
            height: 50,
          ),
        ),
        Positioned(
          left: 15,
          child: Text('8.35 PM'),
        ),
        Positioned(
            child: Column(children: [
          DirectionsCircle(
            height: 25,
            count: isLastIndex ? 8 : 7,
            isLastIndex: isLastIndex,
            isWalking: isWalking,
          ),
        ])),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            isLastIndex
                ? Container(
                    padding: EdgeInsets.only(left: 125),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(arrivalStopName),
                        ),
                        Container(
                          child: Text(subLocationName),
                        )
                      ],
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(left: 125),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(locationName),
                        ),
                        Container(
                          child: Text(subLocationName),
                        )
                      ],
                    ),
                  ),
            Divider(
              height: 50,
              thickness: 1,
              indent: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: showingIcon,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 75),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            instruction,
                          ),
                        ),
                        Container(
                          child: Text(
                            subInstruction,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 50,
              thickness: 1,
              indent: 120,
            ),
            isLastIndex
                ? Container(
                    padding: EdgeInsets.only(left: 125),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(locationName),
                        ),
                        Container(
                          child: Text(subLocationName),
                        )
                      ],
                    ),
                  )
                : Container(),
          ],
        )
      ],
    );
  }
}
