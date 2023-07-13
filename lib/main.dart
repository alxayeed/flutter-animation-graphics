import 'package:animation_graphics/screens/animated_builder.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;
//TODO: show?

void main() {
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
        body: const AnimatedBuilderScreen(),
      ),
    );
  }
}



