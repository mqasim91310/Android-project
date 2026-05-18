// ============================================================
// FILE: lib/services/firebase_service.dart
// Yahan sare CRUD operations likhe hain Firebase ke liye
// ============================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class FirebaseService {
  // Firestore ka instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection name — Firebase mein yeh folder ki tarah hota hai
  final String _collection = 'students';

  // ─────────────────────────────────────────
  // CREATE — Naya student add karna
  // ─────────────────────────────────────────
  Future<void> addStudent(Student student) async {
    try {
      await _firestore.collection(_collection).add(student.toMap());
    } catch (e) {
      throw Exception('Student add karne mein error: $e');
    }
  }

  // ─────────────────────────────────────────
  // READ — Sare students ka real-time stream
  // StreamBuilder ke saath use karo UI mein
  // ─────────────────────────────────────────
  Stream<List<Student>> getStudents() {
    return _firestore
        .collection(_collection)
        .orderBy('name') // naam ke order mein
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Student.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  // ─────────────────────────────────────────
  // READ — Single student by ID
  // ─────────────────────────────────────────
  Future<Student?> getStudentById(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return Student.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Student fetch karne mein error: $e');
    }
  }

  // ─────────────────────────────────────────
  // UPDATE — Existing student ka data update karna
  // ─────────────────────────────────────────
  Future<void> updateStudent(Student student) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(student.id)
          .update(student.toMap());
    } catch (e) {
      throw Exception('Student update karne mein error: $e');
    }
  }

  // ─────────────────────────────────────────
  // DELETE — Student delete karna
  // ─────────────────────────────────────────
  Future<void> deleteStudent(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Student delete karne mein error: $e');
    }
  }
}