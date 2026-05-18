import 'package:flutter/material.dart';

class AnimatedContainerTask extends StatefulWidget {
  const AnimatedContainerTask({super.key});

  @override
  State<AnimatedContainerTask> createState() => _AnimatedContainerTaskState();
}

class _AnimatedContainerTaskState extends State<AnimatedContainerTask> {
  double _width  = 100;
  double _height = 100;
  Color  _color  = Colors.blue;

  // ── Task: Duration in milliseconds / microseconds ─────
  Duration _duration = const Duration(milliseconds: 800);

  // ── Task: Different curves ─────────────────────────────
  Curve _curve = Curves.bounceOut;

  void _changeProperties() {
    setState(() {
      _width  = _width  == 100 ? 220 : 100;
      _height = _height == 100 ? 220 : 100;
      _color  = _color  == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedContainer Task'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── Duration Buttons ───────────────────────
            const Text('⏱  Duration (Task: ms & µs)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _durationBtn('300 ms',       const Duration(milliseconds: 300)),
                _durationBtn('800 ms',       const Duration(milliseconds: 800)),
                _durationBtn('1500 ms',      const Duration(milliseconds: 1500)),
                _durationBtn('800000 µs',    const Duration(microseconds: 800000)),
                _durationBtn('2000000 µs',   const Duration(microseconds: 2000000)),
              ],
            ),

            const SizedBox(height: 16),

            // ── Curve Buttons ──────────────────────────
            const Text('🎢  Curve (Task: bounceIn/Out, elastic etc.)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _curveBtn('bounceOut',   Curves.bounceOut),
                _curveBtn('bounceIn',    Curves.bounceIn),
                _curveBtn('elasticOut',  Curves.elasticOut),
                _curveBtn('elasticIn',   Curves.elasticIn),
                _curveBtn('easeInOut',   Curves.easeInOut),
                _curveBtn('linear',      Curves.linear),
                _curveBtn('decelerate',  Curves.decelerate),
              ],
            ),

            const SizedBox(height: 30),

            // ── Animated Container ─────────────────────
            Center(
              child: AnimatedContainer(
                width:    _width,
                height:   _height,
                color:    _color,
                duration: _duration,
                curve:    _curve,
              ),
            ),

            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Duration: $_duration\nCurve: $_curve',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeProperties,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.play_arrow, color: Colors.white),
      ),
    );
  }

  Widget _durationBtn(String label, Duration d) => ChoiceChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        selected: _duration == d,
        selectedColor: Colors.blue,
        labelStyle: TextStyle(color: _duration == d ? Colors.white : Colors.black),
        onSelected: (_) => setState(() => _duration = d),
      );

  Widget _curveBtn(String label, Curve c) => ChoiceChip(
        label: Text(label, style: const TextStyle(fontSize: 12)),
        selected: _curve == c,
        selectedColor: Colors.deepPurple,
        labelStyle: TextStyle(color: _curve == c ? Colors.white : Colors.black),
        onSelected: (_) => setState(() => _curve = c),
      );
}