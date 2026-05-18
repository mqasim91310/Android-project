// ============================================================
// FILE: lib/pages/home_page.dart
// PAGE 1: Home Page — Students ki list dikhata hai (READ)
//         Yahan se Delete aur Edit bhi kar sakte ho
// ============================================================

import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../services/firebase_service.dart';
import 'add_edit_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _service = FirebaseService();

  // ─── Student Delete karna ───────────────
  Future<void> _deleteStudent(String id, String name) async {
    // Confirmation dialog dikhao pehle
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Confirm'),
        content: Text(
          '"$name" ko delete karna chahte ho?',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _service.deleteStudent(id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Student delete ho gaya ✓'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  // ─── CGPA color indicator ────────────────
  Color _cgpaColor(int cgpa) {
    if (cgpa >= 35) return Colors.green;
    if (cgpa >= 25) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      appBar: AppBar(
        title: const Text(
          '🎓 Student Manager',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: StreamBuilder<List<Student>>(
              stream: _service.getStudents(),
              builder: (context, snapshot) {
                final count = snapshot.data?.length ?? 0;
                return Chip(
                  label: Text(
                    '$count Students',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white24,
                );
              },
            ),
          ),
        ],
      ),
      // ─── MAIN BODY: StreamBuilder se real-time data ───
      body: StreamBuilder<List<Student>>(
        stream: _service.getStudents(),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF6C63FF)),
                  SizedBox(height: 16),
                  Text('Data load ho raha hai...'),
                ],
              ),
            );
          }

          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 12),
                  Text('Error: ${snapshot.error}'),
                ],
              ),
            );
          }

          // Empty state
          final students = snapshot.data ?? [];
          if (students.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline,
                      size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'Koi student nahi mila',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Neeche + button se student add karo',
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
            );
          }

          // ─── Students ki List ──────────────────────────
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  // Avatar with first letter
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF6C63FF),
                    child: Text(
                      student.name.isNotEmpty
                          ? student.name[0].toUpperCase()
                          : '?',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    student.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.badge_outlined,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(student.rollNo,
                              style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 12),
                          const Icon(Icons.school_outlined,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(student.course,
                              style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color:
                                  _cgpaColor(student.cgpa).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'CGPA: ${(student.cgpa / 10).toStringAsFixed(1)}',
                              style: TextStyle(
                                  color: _cgpaColor(student.cgpa),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ─── Action Buttons ─────────────────
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Edit button
                      IconButton(
                        icon: const Icon(Icons.edit_outlined,
                            color: Color(0xFF6C63FF)),
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
                      // Delete button
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () =>
                            _deleteStudent(student.id, student.name),
                        tooltip: 'Delete karo',
                      ),
                    ],
                  ),
                  // Detail page pe jane ke liye tap
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(student: student),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),

      // ─── FAB: Naya student add karna ────────────────────
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Student',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}