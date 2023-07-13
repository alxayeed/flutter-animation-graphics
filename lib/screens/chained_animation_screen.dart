import 'package:flutter/material.dart';


enum CircleSide {left, right}

extension ToPath on CircleSide{
  Path toPath(Size size){
    final path = Path();

    late Offset offset;
    late bool clockWise;

    switch(this){
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
    
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockWise
    );

    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path>{
  final CircleSide circleSide;

  HalfCircleClipper({required this.circleSide});

  @override
  Path getClip(Size size) => circleSide.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}


class ChainedAnimationScreen extends StatelessWidget {
  const ChainedAnimationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: HalfCircleClipper(circleSide: CircleSide.left),
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                  color: Colors.blue
                ),
              ),
            ),
            ClipPath(
              clipper: HalfCircleClipper(circleSide: CircleSide.right),
              child: Container(
                height: 200,
                width: 200,
                decoration: const BoxDecoration(
                    color: Colors.yellow
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
