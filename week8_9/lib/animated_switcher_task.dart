import 'package:flutter/material.dart';

class AnimatedSwitcherTask extends StatefulWidget {
  const AnimatedSwitcherTask({super.key});

  @override
  State<AnimatedSwitcherTask> createState() => _AnimatedSwitcherTaskState();
}

class _AnimatedSwitcherTaskState extends State<AnimatedSwitcherTask> {
  bool _showFirst = true;

  void _switchWidget() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedSwitcher Task'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: _showFirst
                  ? Container(
                      key: const ValueKey(1),
                      width: 150,
                      height: 150,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: const Text(
                        'First',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    )
                  : Container(
                      key: const ValueKey(2),
                      width: 150,
                      height: 150,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: const Text(
                        'Second',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
            ),
            const SizedBox(height: 30),
            Text(
              _showFirst ? 'Showing: First' : 'Showing: Second',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _switchWidget,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.swap_horiz, color: Colors.white),
      ),
    );
  }
}