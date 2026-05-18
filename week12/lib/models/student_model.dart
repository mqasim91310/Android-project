// ============================================================
// FILE: lib/models/student_model.dart
// Yeh Student ka data model hai jise Firebase mein store karte hain
// ============================================================

class Student {
  final String id;       // Firebase document ID
  final String name;     // Student ka naam
  final String rollNo;   // Roll number
  final String email;    // Email address
  final String course;   // Course name
  final int cgpa;        // CGPA (0-4 scale * 10, e.g. 35 = 3.5)

  Student({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.email,
    required this.course,
    required this.cgpa,
  });

  // Firebase se data aata hai Map format mein — usay Student object mein convert karna
  factory Student.fromMap(Map<String, dynamic> map, String docId) {
    return Student(
      id: docId,
      name: map['name'] ?? '',
      rollNo: map['rollNo'] ?? '',
      email: map['email'] ?? '',
      course: map['course'] ?? '',
      cgpa: map['cgpa'] ?? 0,
    );
  }

  // Student object ko Map mein convert karna taake Firebase mein save ho sake
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rollNo': rollNo,
      'email': email,
      'course': course,
      'cgpa': cgpa,
    };
  }

  // Update ke liye copy with method
  Student copyWith({
    String? id,
    String? name,
    String? rollNo,
    String? email,
    String? course,
    int? cgpa,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      rollNo: rollNo ?? this.rollNo,
      email: email ?? this.email,
      course: course ?? this.course,
      cgpa: cgpa ?? this.cgpa,
    );
  }
}