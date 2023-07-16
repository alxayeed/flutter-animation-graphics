import 'package:flutter/material.dart';
import 'dart:math' show pi;
import 'package:vector_math/vector_math_64.dart' show Vector3;

class ThreeDAnimationScreen extends StatefulWidget {
  const ThreeDAnimationScreen({Key? key}) : super(key: key);

  @override
  State<ThreeDAnimationScreen> createState() => _ThreeDAnimationScreenState();
}

class _ThreeDAnimationScreenState extends State<ThreeDAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi);
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  double heightAndWeight = 100.0;
  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

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
        children: [
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              '3D Animations',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 200.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([
                  _xController,
                  _yController,
                  _zController,
                ]),
                builder: (BuildContext context, Widget? child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..rotateX(_animation.evaluate(_xController))
                      ..rotateY(_animation.evaluate(_yController))
                      ..rotateZ(_animation.evaluate(_zController)),
                    child: Stack(
                      children: [
                        //front
                        Container(
                          height: heightAndWeight,
                          width: heightAndWeight,
                          color: Colors.purple,
                        ),
                        // back
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..translate(
                            Vector3(0, 0, -heightAndWeight)
                          ),
                          child: Container(
                            height: heightAndWeight,
                            width: heightAndWeight,
                            color: Colors.blue,
                          ),
                        ),
                        // left
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateY(pi / 2.0),
                          child: Container(
                            height: heightAndWeight,
                            width: heightAndWeight,
                            color: Colors.orange,
                          ),
                        ),
                        // right
                        Transform(
                          alignment: Alignment.centerRight,
                          transform: Matrix4.identity()..rotateY(- pi / 2),
                          child: Container(
                            height: heightAndWeight,
                            width: heightAndWeight,
                            color: Colors.cyan,
                          ),
                        ),
                        // top
                        Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()..rotateX(- pi / 2),
                          child: Container(
                            height: heightAndWeight,
                            width: heightAndWeight,
                            color: Colors.greenAccent,
                          ),
                        ),
                        // bottom
                        Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()..rotateX(pi / 2),
                          child: Container(
                            height: heightAndWeight,
                            width: heightAndWeight,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
