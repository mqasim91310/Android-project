import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceScreen extends StatefulWidget {
  const SharedPreferenceScreen({super.key});

  @override
  State<SharedPreferenceScreen> createState() =>
      _SharedPreferenceScreenState();
}

class _SharedPreferenceScreenState extends State<SharedPreferenceScreen> {
  String name = '';
  int age = 0;
  String email = '';
  double gpa = 0.0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      name = sp.getString('name') ?? 'Not saved yet';
      age = sp.getInt('age') ?? 0;
      email = sp.getString('email') ?? 'Not saved yet';
      gpa = sp.getDouble('gpa') ?? 0.0;
    });
  }

  Future<void> saveData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    await sp.setString('name', 'Ali Hassan');
    await sp.setInt('age', 21);
    await sp.setBool('isLogin', true);
    await sp.setDouble('lucky_number', 7.7);
    await sp.setString('email', 'ali.hassan@riphah.edu.pk');
    await sp.setDouble('gpa', 3.85);

    await loadData();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Data Saved Successfully!'),
        backgroundColor: Colors.teal,
      ),
    );
  }

  Future<void> clearData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.clear();
    await loadData();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🗑️ Data Cleared!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '📦 Stored Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _dataCard(
              icon: Icons.person,
              label: 'Name  (String)',
              value: name,
              color: Colors.blue.shade50,
              iconColor: Colors.blue,
            ),
            _dataCard(
              icon: Icons.cake,
              label: 'Age  (int)',
              value: age.toString(),
              color: Colors.orange.shade50,
              iconColor: Colors.orange,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('✅ Task — 2 New Data Types',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            _dataCard(
              icon: Icons.email,
              label: 'Email  (String)  ← NEW',
              value: email,
              color: Colors.green.shade50,
              iconColor: Colors.green,
            ),
            _dataCard(
              icon: Icons.grade,
              label: 'GPA  (double)  ← NEW',
              value: gpa.toStringAsFixed(2),
              color: Colors.purple.shade50,
              iconColor: Colors.purple,
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: saveData,
              icon: const Icon(Icons.save),
              label: const Text('Save Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: clearData,
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Clear Data',
                  style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _dataCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(fontSize: 11, color: Colors.black54)),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
