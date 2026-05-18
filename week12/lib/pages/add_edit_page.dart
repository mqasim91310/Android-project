// ============================================================
// FILE: lib/pages/add_edit_page.dart
// PAGE 2: Add/Edit Page — CREATE aur UPDATE dono yahan hote hain
//         Agar student null ho to naya add karo,
//         warna existing student update karo
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/student_model.dart';
import '../services/firebase_service.dart';

class AddEditPage extends StatefulWidget {
  // Agar student diya to edit mode, nahi to add mode
  final Student? student;

  const AddEditPage({super.key, this.student});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final FirebaseService _service = FirebaseService();
  final _formKey = GlobalKey<FormState>(); // Form validation ke liye

  // Text controllers
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _cgpaController = TextEditingController();

  // Dropdown ke liye
  String _selectedCourse = 'BSCS';
  final List<String> _courses = [
    'BSCS',
    'BSIT',
    'BSSE',
    'BSAI',
    'MCS',
    'MIT',
  ];

  bool _isLoading = false;
  bool get _isEditMode => widget.student != null; // Edit ya Add?

  @override
  void initState() {
    super.initState();
    // Agar edit mode hai to pehle se data fill karo
    if (_isEditMode) {
      _nameController.text = widget.student!.name;
      _rollNoController.text = widget.student!.rollNo;
      _emailController.text = widget.student!.email;
      _cgpaController.text = (widget.student!.cgpa / 10).toStringAsFixed(1);
      _selectedCourse = widget.student!.course;
    }
  }

  @override
  void dispose() {
    // Memory leak se bachne ke liye controllers dispose karo
    _nameController.dispose();
    _rollNoController.dispose();
    _emailController.dispose();
    _cgpaController.dispose();
    super.dispose();
  }

  // ─── Form Submit: CREATE ya UPDATE ───────
  Future<void> _submitForm() async {
    // Validation check karo
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final cgpaValue = (double.parse(_cgpaController.text) * 10).toInt();

      if (_isEditMode) {
        // ── UPDATE: Existing student update karo ──
        final updated = widget.student!.copyWith(
          name: _nameController.text.trim(),
          rollNo: _rollNoController.text.trim(),
          email: _emailController.text.trim(),
          course: _selectedCourse,
          cgpa: cgpaValue,
        );
        await _service.updateStudent(updated);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Student update ho gaya ✓'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } else {
        // ── CREATE: Naya student add karo ──
        final newStudent = Student(
          id: '', // Firebase apna ID deta hai
          name: _nameController.text.trim(),
          rollNo: _rollNoController.text.trim(),
          email: _emailController.text.trim(),
          course: _selectedCourse,
          cgpa: cgpaValue,
        );
        await _service.addStudent(newStudent);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Student add ho gaya ✓'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      appBar: AppBar(
        title: Text(
          _isEditMode ? '✏️ Student Edit karo' : '➕ Naya Student',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header card ──────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFF9C88FF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person_add, color: Colors.white, size: 32),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEditMode ? 'Student Edit' : 'Student Register',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _isEditMode
                              ? 'Information update karo'
                              : 'Naya student add karo',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ─── Name Field ───────────────────────────
              _buildLabel('Student ka Naam', Icons.person),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Jaise: Ali Hassan',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Naam zaroori hai';
                  }
                  if (value.trim().length < 2) {
                    return 'Naam kam se kam 2 characters ka ho';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ─── Roll No Field ────────────────────────
              _buildLabel('Roll Number', Icons.badge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _rollNoController,
                textCapitalization: TextCapitalization.characters,
                decoration: const InputDecoration(
                  hintText: 'Jaise: BSCS-F21-001',
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Roll number zaroori hai';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ─── Email Field ──────────────────────────
              _buildLabel('Email Address', Icons.email),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Jaise: ali@university.edu.pk',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email zaroori hai';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value.trim())) {
                    return 'Valid email likho';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // ─── Course Dropdown ──────────────────────
              _buildLabel('Course', Icons.school),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.school_outlined),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
                items: _courses
                    .map((course) => DropdownMenuItem(
                          value: course,
                          child: Text(course),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() => _selectedCourse = value!);
                },
              ),
              const SizedBox(height: 16),

              // ─── CGPA Field ───────────────────────────
              _buildLabel('CGPA (0.0 – 4.0)', Icons.star),
              const SizedBox(height: 8),
              TextFormField(
                controller: _cgpaController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,1}')),
                ],
                decoration: const InputDecoration(
                  hintText: 'Jaise: 3.5',
                  prefixIcon: Icon(Icons.star_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'CGPA zaroori hai';
                  }
                  final cgpa = double.tryParse(value.trim());
                  if (cgpa == null) return 'Valid number likho';
                  if (cgpa < 0.0 || cgpa > 4.0) {
                    return 'CGPA 0.0 aur 4.0 ke beech hona chahiye';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // ─── Submit Button ────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          _isEditMode ? '✓ Update Karo' : '+ Student Add Karo',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // ─── Cancel Button ────────────────────────
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF6C63FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Color(0xFF6C63FF), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Reusable Label Widget ────────────────
  Widget _buildLabel(String text, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF6C63FF)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}