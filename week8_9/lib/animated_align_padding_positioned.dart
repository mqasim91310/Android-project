import 'package:flutter/material.dart';

class AnimatedAlignPaddingPositionedTask extends StatefulWidget {
  const AnimatedAlignPaddingPositionedTask({super.key});

  @override
  State<AnimatedAlignPaddingPositionedTask> createState() =>
      _AnimatedAlignPaddingPositionedTaskState();
}

class _AnimatedAlignPaddingPositionedTaskState
    extends State<AnimatedAlignPaddingPositionedTask> {
  Alignment  _alignment = Alignment.topLeft;
  EdgeInsets _padding   = EdgeInsets.all(10);
  double     _position  = 50;

  void _animateProperties() {
    setState(() {
      _alignment = _alignment == Alignment.topLeft
          ? Alignment.bottomRight
          : Alignment.topLeft;
      _padding = _padding == EdgeInsets.all(10)
          ? EdgeInsets.all(50)
          : EdgeInsets.all(10);
      _position = _position == 50 ? 150 : 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Align, Padding, Positioned'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // AnimatedAlign — blue box
          AnimatedAlign(
            alignment: _alignment,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            child: Container(
              width: 50,
              height: 50,
              color: Colors.blue,
              child: const Center(
                child: Text('Align', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ),

          // AnimatedPadding — green box
          Center(
            child: AnimatedPadding(
              padding: _padding,
              duration: const Duration(seconds: 1),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.green,
                child: const Center(
                  child: Text('Padding', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ),
          ),

          // AnimatedPositioned — red box
          AnimatedPositioned(
            left: _position,
            top: _position,
            duration: const Duration(seconds: 1),
            child: Container(
              width: 50,
              height: 50,
              color: Colors.red,
              child: const Center(
                child: Text('Pos', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateProperties,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }
}