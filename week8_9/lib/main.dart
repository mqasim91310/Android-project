import 'package:flutter/material.dart';
import 'animated_container_task.dart';
import 'animated_opacity_task.dart';
import 'animated_align_padding_positioned.dart';
import 'animated_switcher_task.dart';
import 'explicit_rotation_task.dart';
import 'hometask_transitions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Week 8/9',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [
      {
        'title': '1. AnimatedContainer',
        'subtitle': 'Color, Size + ms/µs curves',
        'icon': Icons.crop_square,
        'color': Colors.blue,
        'page': const AnimatedContainerTask(),
      },
      {
        'title': '2. AnimatedOpacity',
        'subtitle': 'Fade In / Fade Out',
        'icon': Icons.opacity,
        'color': Colors.orange,
        'page': const AnimatedOpacityTask(),
      },
      {
        'title': '3. Align, Padding, Positioned',
        'subtitle': 'Layout animations',
        'icon': Icons.align_horizontal_center,
        'color': Colors.pink,
        'page': const AnimatedAlignPaddingPositionedTask(),
      },
      {
        'title': '4. AnimatedSwitcher',
        'subtitle': 'Widget transition',
        'icon': Icons.swap_horiz,
        'color': Colors.teal,
        'page': const AnimatedSwitcherTask(),
      },
      {
        'title': '5. Explicit: Rotation',
        'subtitle': 'AnimationController + Stop/Start',
        'icon': Icons.rotate_right,
        'color': Colors.red,
        'page': const ExplicitRotationTask(),
      },
      {
        'title': '6. HomeTask: 3 Transitions',
        'subtitle': 'Size + Rotation + Align',
        'icon': Icons.animation,
        'color': Colors.indigo,
        'page': const HomeTaskTransitions(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Animations — Week 8/9'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: pages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = pages[index];
          return ListTile(
            tileColor: (item['color'] as Color).withValues(alpha: 0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: CircleAvatar(
              backgroundColor: item['color'] as Color,
              child: Icon(item['icon'] as IconData, color: Colors.white),
            ),
            title: Text(item['title'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['subtitle'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item['page'] as Widget),
            ),
          );
        },
      ),
    );
  }
}