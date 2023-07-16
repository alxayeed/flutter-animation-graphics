import 'package:animation_graphics/screens/3d_animation.dart';
import 'package:animation_graphics/screens/animated_builder.dart';
import 'package:animation_graphics/screens/chained_animation_screen.dart';
import 'package:animation_graphics/screens/hero_animation_screen.dart';
import 'package:animation_graphics/screens/implicit_animation.dart';
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
    List<Map<String, dynamic>> items = [
      {
        "name": "Animated Builder",
        "screen": AnimatedBuilderScreen()
      },
      {
        "name": "Chained Animation(Clipper,Curves)",
        "screen": ChainedAnimationScreen()
      },
      {
        "name": "3D Animation",
        "screen": ThreeDAnimationScreen()
      },
      {
        "name":  "Hero Animation",
        "screen": HeroAnimationScreen()
      },
      {
        "name":  "Implicit Animation",
        "screen": ImplicitAnimationScreen()
      },
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
            ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(10.0),
                  color: Colors.greenAccent,
                  child: Center(
                    child: ListTile(
                      title: Text(items[index]["name"]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => items[index]["screen"],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },),
        ),
      ),
    );
  }
}
