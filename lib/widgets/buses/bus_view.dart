import 'package:flutter/material.dart';

class BusView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BusView();
  }
}

class _BusView extends State<BusView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Bus'),
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.topLeft,
                    overflow: Overflow.clip,
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          height: 50,
                        ),
                      ),
                      Positioned(
                        child: Icon(Icons.directions_walk),
                      ),
                      Positioned(
                        child: CustomPaint(
                          size: MediaQuery.of(context).size,
                          painter: Sky(),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 150),
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                          'datasssssssssssssssssssssssssssssssssssssssssaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                )
              ],
            )));
  }
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 5
      ..color = Colors.black;
    canvas.drawLine(Offset(100, 0), Offset(100, 150), paint);
  }

  @override
  bool shouldRepaint(Sky oldDelegate) => false;
}
