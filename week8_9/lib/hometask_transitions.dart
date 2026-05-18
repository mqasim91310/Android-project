import 'package:flutter/material.dart';

class HomeTaskTransitions extends StatefulWidget {
  const HomeTaskTransitions({super.key});

  @override
  State<HomeTaskTransitions> createState() => _HomeTaskTransitionsState();
}

class _HomeTaskTransitionsState extends State<HomeTaskTransitions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double>             _sizeAnim;
  late Animation<double>             _rotationAnim;
  late Animation<AlignmentGeometry>  _alignAnim;

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // 1. SizeTransition
    _sizeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 2. RotationTransition
    _rotationAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 3. AlignTransition
    _alignAnim = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      if (_isPlaying) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeTask: 3 Transitions'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ── 1. SizeTransition ───────────────────
            _sectionTitle('1️⃣  SizeTransition'),
            const SizedBox(height: 8),
            Center(
              child: SizeTransition(
                sizeFactor: _sizeAnim,
                axis: Axis.horizontal,
                axisAlignment: 0,
                child: Container(
                  height: 70,
                  width: 220,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'SizeTransition',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── 2. RotationTransition ────────────────
            _sectionTitle('2️⃣  RotationTransition'),
            const SizedBox(height: 8),
            Center(
              child: RotationTransition(
                turns: _rotationAnim,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 40),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── 3. AlignTransition ───────────────────
            _sectionTitle('3️⃣  AlignTransition'),
            const SizedBox(height: 8),
            SizedBox(
              height: 120,
              child: AlignTransition(
                alignment: _alignAnim,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.circle, color: Colors.white),
                ),
              ),
            ),

            const Spacer(),

            // ── Play / Reverse button ────────────────
            ElevatedButton.icon(
              onPressed: _toggleAnimation,
              icon: Icon(_isPlaying ? Icons.replay : Icons.play_arrow),
              label: Text(_isPlaying ? 'Reverse' : 'Play All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
}