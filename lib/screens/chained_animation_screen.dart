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
  Future<void> delayed(Duration duration){
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
  late Animation<double> _rotationAnimation;

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
    _rotationAnimationController..reset()..forward.delayed(const Duration(seconds: 1));
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
          builder: (context, child){
            return Transform(
              transform: Matrix4.identity()..rotateZ(_rotationAnimation.value),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipPath(
                    clipper: HalfCircleClipper(circleSide: CircleSide.left),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(color: Colors.blue),
                    ),
                  ),
                  ClipPath(
                    clipper: HalfCircleClipper(circleSide: CircleSide.right),
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(color: Colors.yellow),
                    ),
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
