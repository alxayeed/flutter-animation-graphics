import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSide { left, right }

//TODO: extension and it's usage
extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }

    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockWise);

    path.close();
    return path;
  }
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) {
    return Future.delayed(duration, this);
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide circleSide;

  HalfCircleClipper({required this.circleSide});

  @override
  Path getClip(Size size) => circleSide.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class ChainedAnimationScreen extends StatefulWidget {
  /// This is a widget to demonstrate Chained Animation, Curves and Clippers
  const ChainedAnimationScreen({Key? key}) : super(key: key);

  @override
  State<ChainedAnimationScreen> createState() => _ChainedAnimationScreenState();
}

//TODO: mixins and their usages
class _ChainedAnimationScreenState extends State<ChainedAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationAnimationController;
  late AnimationController _flipAnimationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2),
    ).animate(
      CurvedAnimation(
        parent: _rotationAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    // flip Animation
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(
          parent: _flipAnimationController, curve: Curves.bounceOut),
    );

    // status listener for rotation controller
    _rotationAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(
                begin: _flipAnimation.value, end: _flipAnimation.value + pi)
            .animate(
          CurvedAnimation(
              parent: _flipAnimationController, curve: Curves.bounceOut),
        );
        // reset the flip controller and start the animation
        _flipAnimationController..reset()..forward();
      }
    });

    // status listener for flip controller
    _flipAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _rotationAnimation = Tween<double>(
          begin: _rotationAnimation.value,
          end: _rotationAnimation.value -(pi / 2),
        ).animate(
          CurvedAnimation(
            parent: _rotationAnimationController,
            curve: Curves.bounceOut,
          ),
        );

        _rotationAnimationController..reset()..forward();

      }
    });

    // _rotationAnimationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rotationAnimationController
      ..reset()
      ..forward.delayed(const Duration(seconds: 1));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        const Center(
          child: Text(
            'Chained Animations',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        AnimatedBuilder(
          animation: _rotationAnimationController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()..rotateZ(_rotationAnimation.value),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipAnimationController,
                    builder: (context, child){
                      return Transform(
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        alignment: Alignment.centerRight,
                        child: ClipPath(
                          clipper: HalfCircleClipper(circleSide: CircleSide.left),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: const BoxDecoration(color: Colors.blue),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: HalfCircleClipper(circleSide: CircleSide.right),
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: const BoxDecoration(color: Colors.yellow),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
