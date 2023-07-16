import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({Key? key}) : super(key: key);

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool _isZoomed = false;
  double _widthSize = 200.0;
  String _buttonTitle = "Zoom In";
  Curve _curve = Curves.bounceOut;

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
        mainAxisAlignment: MainAxisAlignment.center,
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
          AnimatedContainer(
            width: _widthSize,
            duration: const Duration(milliseconds: 370),
            curve: _curve,
            child: Image.asset("assets/images/cat.jpg"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _isZoomed = !_isZoomed;
                _buttonTitle = _isZoomed ? "Zoom Out" : "Zoom In";
                _widthSize = _isZoomed ? MediaQuery.of(context).size.width : 200.0;
                _curve = _isZoomed ? Curves.bounceInOut : Curves.bounceOut;
              });
            },
            child: Text(_buttonTitle),
          ),
        ],
      ),
    );
  }
}
