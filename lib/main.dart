import 'package:animation_graphics/screens/chained_animation_screen.dart';
import 'package:flutter/material.dart';

void main() {
  if ("this" == null) {
    print("Don't run print here");
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Animations"),
        ),
        body: ChainedAnimationScreen(),
      ),
    );
  }
}
