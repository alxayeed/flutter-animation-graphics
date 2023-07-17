import 'package:flutter/material.dart';
import 'dart:math' as math;

class TweenAnimationBuilderScreen extends StatefulWidget {
  const TweenAnimationBuilderScreen({Key? key}) : super(key: key);

  @override
  State<TweenAnimationBuilderScreen> createState() =>
      _TweenAnimationBuilderScreenState();
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();

  @override
  Path getClip(Size size) {
    var path = Path();

    var rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    path.addOval(rect);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Color getRandomColor() {
  return Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));
}

class _TweenAnimationBuilderScreenState
    extends State<TweenAnimationBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    double heightAndWidth = MediaQuery.of(context).size.width;
    Color color = getRandomColor();

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
              'Tween Animation Builder',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          ClipPath(
            clipper: const CircleClipper(),
            child: Center(
                child: TweenAnimationBuilder(
              tween: ColorTween(
                begin: getRandomColor() ,
                end: color,
              ),
              onEnd: (){
                setState(() {
                  color = getRandomColor();
                });
              },
              duration: const Duration(seconds: 1),
              child: Container(
                height: heightAndWidth,
                width: heightAndWidth,
                color: Colors.red,
              ),
              builder: (BuildContext context, Color? value, Widget? child) {
                return ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    value!,
                    BlendMode.srcATop,
                  ),
                  child: child,
                );
              },
            )),
          )
        ],
      ),
    );
  }
}
