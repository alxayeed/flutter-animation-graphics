import 'package:flutter/material.dart';
import 'dart:math' show pi, sin, cos;

class CustomPainterScreen extends StatefulWidget {
  const CustomPainterScreen({Key? key}) : super(key: key);

  @override
  State<CustomPainterScreen> createState() => _CustomPainterScreenState();
}

class _CustomPainterScreenState extends State<CustomPainterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animations"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              'Custom Painter and Polygons',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: CustomPaint(
              painter: Polygon(sides: 3),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Polygon extends CustomPainter {
  final int sides;

  Polygon({required this.sides});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
    ..color = Colors.black
      ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 3;

    var path = Path();

    final center = Offset(size.width / 2, size.height / 2);
    double angle = (2 * pi) / sides;
    final radius = size.width / 2;

    final x = center.dx + radius * cos(0);
    final y = center.dy + radius * sin(0);

    path.moveTo(x, y);

    List<double> angles = List.generate(sides, (index) => index * angle);

    for (angle in angles){
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is Polygon && oldDelegate.sides != sides;
}
