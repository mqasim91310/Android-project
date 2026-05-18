// lib/screens/admin/admin_login_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import 'admin_main_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey       = GlobalKey<FormState>();
  final _emailCtrl     = TextEditingController(text: 'admin@brewbliss.com');
  final _passwordCtrl  = TextEditingController();
  bool _obscure        = true;
  bool _rememberMe     = false;
  bool _isLoading      = false;

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AdminMainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.lightGrey,
      body: Row(
        children: [
          // ── Left brand panel (visible on wide screens) ──
          if (MediaQuery.of(context).size.width > 600)
            Expanded(
              child: Container(
                color: AdminColors.darkBrown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('☕', style: TextStyle(fontSize: 80)),
                    const SizedBox(height: 20),
                    Text(
                      'Brew & Bliss',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AdminColors.white,
                      ),
                    ),
                    Text(
                      'Admin Panel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AdminColors.gold,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(height: 40),
                    _featureTile(Icons.dashboard, 'Real-time Dashboard'),
                    _featureTile(Icons.receipt_long, 'Order Management'),
                    _featureTile(Icons.bar_chart, 'Sales Analytics'),
                    _featureTile(Icons.people, 'Customer Management'),
                  ],
                ),
              ),
            ),

          // ── Login form ──
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mobile logo
                      if (MediaQuery.of(context).size.width <= 600) ...[
                        const Center(
                          child: Text('☕', style: TextStyle(fontSize: 50)),
                        ),
                        Center(
                          child: Text(
                            'Brew & Bliss Admin',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AdminColors.darkBrown,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],

                      Text('Welcome Back 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AdminColors.darkBrown,
                          )),
                      const SizedBox(height: 6),
                      Text('Sign in to your admin account',
                          style: GoogleFonts.poppins(
                              color: AdminColors.grey, fontSize: 14)),
                      const SizedBox(height: 32),

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Email
                            TextFormField(
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Admin Email',
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: AdminColors.mediumBrown),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Required';
                                if (!v.contains('@')) return 'Enter valid email';
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            // Password
                            TextFormField(
                              controller: _passwordCtrl,
                              obscureText: _obscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline,
                                    color: AdminColors.mediumBrown),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AdminColors.grey,
                                  ),
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure),
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) return 'Required';
                                if (v.length < 6) {
                                  return 'Minimum 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),

                            // Remember me + Forgot
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v ?? false),
                                  activeColor: AdminColors.darkBrown,
                                ),
                                Expanded(
                                  child: Text(
                                    'Remember me',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: AdminColors.mediumBrown),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text('Forgot password?',
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: AdminColors.mediumBrown)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _login,
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          color: AdminColors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Sign In to Admin Panel'),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Demo credentials
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AdminColors.gold.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: AdminColors.gold.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              const Icon(Icons.info_outline,
                                  color: AdminColors.gold, size: 16),
                              const SizedBox(width: 6),
                              Text('Demo Credentials',
                                  style: GoogleFonts.poppins(
                                    color: AdminColors.gold,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  )),
                            ]),
                            const SizedBox(height: 6),
                            Text('Email: admin@brewbliss.com',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: AdminColors.mediumBrown)),
                            Text('Password: admin123',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: AdminColors.mediumBrown)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureTile(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AdminColors.gold, size: 20),
          const SizedBox(width: 12),
          Text(label,
              style: GoogleFonts.poppins(
                  color: AdminColors.lightBrown, fontSize: 14)),
        ],
      ),
    );
  }
}
