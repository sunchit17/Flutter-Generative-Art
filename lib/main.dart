import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Generative Art',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          child: CustomPaint(
            painter: DemoPainter(),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    renderDrawing(canvas, size);
  }

  void renderDrawing(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.black87);
    int iter = 13;

    renderStructure(canvas, size, iter, iter);
  }

  void renderStructure(Canvas canvas, Size size, int iter, int initIter) {
    if (iter == 0) {
      return;
    }
    double distance = 0.0;

    Color c = colors[Random().nextInt(colors.length)].color;

    for (double i = 0; i < 1000; i = i + 0.01) {
      canvas.drawCircle(
        Offset(
          (size.width / 2) +
              // Change "atan(distance) * sin(distance) * cos(distance)"
              (distance * atan(distance) * sin(distance) * tan(distance)),
          (size.height / 2) +
              // Same changes for these as the top
              // Note that if the top functions and these are the same, you'll get a 45 degree line of points
              (distance * tan(distance) * cos(distance) * atan(distance)),
        ),
        5.0 - (0.5 * (initIter - iter)),
        Paint()..color = c,
      );
      distance = distance + (0.2 + (0.4 * initIter - iter));
    }
    renderStructure(canvas, size, iter - 1, initIter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

var colors = [
  ColorInfo("red", Colors.red, Colors.red[500].toString()),
  ColorInfo("green", Colors.green, Colors.green[500].toString()),
  ColorInfo("blue", Colors.blue, Colors.blue[500].toString()),
  ColorInfo("yellow", Colors.yellow, Colors.yellow[500].toString()),
  ColorInfo("purple", Colors.purple, Colors.purple[500].toString()),
  ColorInfo("amber", Colors.amber, Colors.amber[500].toString()),
  ColorInfo("cyan", Colors.cyan, Colors.cyan[500].toString()),
  ColorInfo("lime", Colors.lime, Colors.grey[500].toString()),
  ColorInfo("indigo",Colors.indigo,Colors.indigo[500].toString()),
  ColorInfo("teal", Colors.teal, Colors.teal[500].toString()),
  ColorInfo("pink", Colors.pink, Colors.pink[500].toString()),
  ColorInfo("orange", Colors.orange, Colors.orange[500].toString()),
];

class ColorInfo {
  String name;
  MaterialColor color;
  String hex;

  ColorInfo(this.name, this.color, this.hex);
}
