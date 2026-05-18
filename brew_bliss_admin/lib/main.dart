// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/admin_theme.dart';
import 'screens/admin/admin_login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const BrewBlissAdminApp());
}

class BrewBlissAdminApp extends StatelessWidget {
  const BrewBlissAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brew & Bliss Admin',
      debugShowCheckedModeBanner: false,
      theme: AdminTheme.theme,
      home: const AdminLoginScreen(),
    );
  }
}
