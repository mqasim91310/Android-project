// ============================================================
// FILE: lib/pages/detail_page.dart
// PAGE 3: Detail Page — Student ki poori info dikhata hai
//         Yahan se Edit aur Delete dono kar sakte ho
// ============================================================

import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../services/firebase_service.dart';
import 'add_edit_page.dart';

class DetailPage extends StatelessWidget {
  final Student student;

  const DetailPage({super.key, required this.student});

  // ─── Delete with confirmation ─────────────
  Future<void> _deleteStudent(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Confirm'),
          ],
        ),
        content: Text(
          '"${student.name}" ko permanently delete karna chahte ho?\nYeh action undo nahi ho sakta.',
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child:
                const Text('Haan Delete Karo', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        await FirebaseService().deleteStudent(student.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Student delete ho gaya ✓'),
              backgroundColor: Colors.green,
            ),
          );
          // Home page pe wapis jao
          Navigator.pop(context);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  // ─── CGPA badge color ────────────────────
  Color _cgpaColor(int cgpa) {
    if (cgpa >= 35) return Colors.green;
    if (cgpa >= 25) return Colors.orange;
    return Colors.red;
  }

  String _cgpaGrade(int cgpa) {
    if (cgpa >= 38) return 'A+ (Excellent)';
    if (cgpa >= 35) return 'A (Very Good)';
    if (cgpa >= 30) return 'B (Good)';
    if (cgpa >= 25) return 'C (Average)';
    return 'D (Below Average)';
  }

  @override
  Widget build(BuildContext context) {
    final cgpaDouble = student.cgpa / 10;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      body: CustomScrollView(
        slivers: [
          // ─── Top Profile Header ──────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            actions: [
              // Edit button in AppBar
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddEditPage(student: student),
                    ),
                  );
                },
                tooltip: 'Edit karo',
              ),
              // Delete button in AppBar
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _deleteStudent(context),
                tooltip: 'Delete karo',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6C63FF), Color(0xFF9C88FF)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    // Avatar
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Text(
                        student.name.isNotEmpty
                            ? student.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Color(0xFF6C63FF),
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      student.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      student.rollNo,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ─── Student Details ─────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ─── CGPA Card ───────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _cgpaColor(student.cgpa).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _cgpaColor(student.cgpa).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('CGPA',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey)),
                          const SizedBox(height: 4),
                          Text(
                            _cgpaGrade(student.cgpa),
                            style: TextStyle(
                                color: _cgpaColor(student.cgpa),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        cgpaDouble.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: _cgpaColor(student.cgpa),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ─── Info Cards ──────────────────────
                const Text(
                  'Student Information',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _buildInfoCard(
                    Icons.person, 'Naam', student.name, Colors.blue),
                _buildInfoCard(
                    Icons.badge, 'Roll Number', student.rollNo, Colors.purple),
                _buildInfoCard(
                    Icons.email, 'Email', student.email, Colors.teal),
                _buildInfoCard(
                    Icons.school, 'Course', student.course, Colors.orange),

                const SizedBox(height: 32),

                // ─── Edit Button ──────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddEditPage(student: student),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Karo',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ─── Delete Button ────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () => _deleteStudent(context),
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    label: const Text(
                      'Delete Karo',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Reusable Info Card ───────────────────
  Widget _buildInfoCard(
      IconData icon, String label, String value, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(label,
            style: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
        subtitle: Text(value,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333))),
      ),
    );
  }
}