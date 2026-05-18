import 'package:flutter/material.dart';

class ExplicitRotationTask extends StatefulWidget {
  const ExplicitRotationTask({super.key});

  @override
  State<ExplicitRotationTask> createState() => _ExplicitRotationTaskState();
}

class _ExplicitRotationTaskState extends State<ExplicitRotationTask>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.repeat(); // auto start rotation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explicit Rotation'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              alignment: Alignment.center,
              turns: Tween<double>(begin: 0, end: 1)
                  .animate(_animationController),
              child: Container(
                height: 200,
                width: 200,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'Rotating!',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Press button to Stop / Start',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_animationController.isAnimating) {
              _animationController.stop();
            } else {
              _animationController.repeat();
            }
          });
        },
        backgroundColor: Colors.red,
        child: Icon(
          _animationController.isAnimating ? Icons.stop : Icons.play_arrow,
          color: Colors.white,
        ),
      ),
    );
  }
}