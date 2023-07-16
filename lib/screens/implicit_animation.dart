import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool isZoomed = false;
  double widthSize = 200.0;
  String buttonTitle = "Zoom In";

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
        children: [
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              'Implicit Animation',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: widthSize,
            child: Image.asset("assets/images/cat.jpg"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isZoomed = !isZoomed;
                buttonTitle = isZoomed ? "Zoom Out" : "Zoom In";
                widthSize = isZoomed ? MediaQuery.of(context).size.width : 200.0;
              });
            },
            child: Text(buttonTitle),
          ),
        ],
      ),
    );
  }
}
