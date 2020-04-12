import 'package:flutter/material.dart';

class DirectionsCircle extends StatelessWidget {
  final double height;
  final Color color;
  final int count;
  final bool isWalking;
  final bool isLastIndex;

  const DirectionsCircle(
      {this.height = 1,
      this.color = Colors.black,
      this.count = 0,
      this.isWalking = true,
      this.isLastIndex = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final dashWidth = 10.0;
        final dashCount = count;
        return Flex(
          children: List.generate(dashCount, (int index) {
            if (index == 0) {
              return SizedBox(
                  width: dashWidth,
                  height: height,
                  child: CustomPaint(
                    // size: MediaQuery.of(context).size,
                    painter: DrawLargeCircles(),
                  ));
            }
            if (isLastIndex && index == dashCount - 1) {
              return SizedBox(
                  width: dashWidth,
                  height: height,
                  child: CustomPaint(
                    // size: MediaQuery.of(context).size,
                    painter: DrawLargeCircles(),
                  ));
            }
            return SizedBox(
                width: dashWidth,
                height: height,
                child: CustomPaint(
                  // size: MediaQuery.of(context).size,
                  painter: isWalking ? DrawCircles() : DrawLines(),
                ));
          }),
          direction: Axis.vertical,
        );
      },
    );
  }
}

class DrawCircles extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blueAccent;

    canvas.drawCircle(Offset(100, 10), 5, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class DrawLargeCircles extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(100, 10), 6, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class DrawLines extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.greenAccent;

    canvas.drawLine(Offset(100, -5), Offset(100, 25), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
