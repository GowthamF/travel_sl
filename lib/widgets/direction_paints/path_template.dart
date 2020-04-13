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
  final Color color;
  final String time;
  final String arrivalStopTime;

  PathTemplate(
      {this.isLastIndex = false,
      this.isWalking = true,
      this.locationName = '',
      this.instruction = '',
      this.subInstruction = '',
      this.subLocationName = '',
      this.arrivalStopName = '',
      this.showingIcon,
      this.color,
      this.time = '',
      this.arrivalStopTime = ''});

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
          child: Column(
            children: [
              DirectionsCircle(
                height: 25,
                count: isLastIndex ? 8 : 7,
                isLastIndex: isLastIndex,
                isWalking: isWalking,
                color: color,
              ),
            ],
          ),
        ),
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
        ),
        isLastIndex
            ? Positioned(
                left: 15,
                child: Column(
                  children: <Widget>[Text(arrivalStopTime)],
                ),
              )
            : Positioned(
                left: 15,
                child: Column(
                  children: <Widget>[Text(time)],
                ),
              ),
        isLastIndex
            ? Container(
                margin: EdgeInsets.only(top: 175, left: 15), child: Text(time))
            : Container(),
      ],
    );
  }
}
