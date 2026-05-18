// lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricEnabled = true;

  final List<Map<String, dynamic>> _orderHistory = [
    {
      'id': 'BB-4821',
      'items': 'Caramel Latte × 2',
      'date': 'May 07, 2026',
      'total': '\$10.00',
      'status': 'Completed',
    },
    {
      'id': 'BB-3917',
      'items': 'Cold Brew + Croissant',
      'date': 'May 05, 2026',
      'total': '\$8.75',
      'status': 'Completed',
    },
    {
      'id': 'BB-3201',
      'items': 'Frappuccino Mocha',
      'date': 'May 02, 2026',
      'total': '\$6.25',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.darkBrown,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.darkBrown,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.gold.withValues(alpha: 0.2),
                            child: Text(
                              'MQ',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: AppColors.gold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.gold,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 14,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Muhammad Qasim',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'm.qasim@email.com',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: AppColors.lightBrown,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      _statCard('12', 'Orders', Icons.receipt_long),
                      const SizedBox(width: 12),
                      _statCard('3/5', 'Stamps', Icons.local_cafe),
                      const SizedBox(width: 12),
                      _statCard('Gold', 'Tier', Icons.workspace_premium),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Account Settings
                  Text(
                    'Account',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _settingsCard(children: [
                    _settingsTile(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () => _showEditProfileDialog(context),
                    ),
                    _divider(),
                    _settingsTile(
                      icon: Icons.location_on_outlined,
                      title: 'Saved Addresses',
                      onTap: () {},
                    ),
                    _divider(),
                    _settingsTile(
                      icon: Icons.credit_card_outlined,
                      title: 'Payment Methods',
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // Preferences
                  Text(
                    'Preferences',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _settingsCard(children: [
                    _switchTile(
                      icon: Icons.notifications_outlined,
                      title: 'Push Notifications',
                      value: _notificationsEnabled,
                      onChanged: (v) =>
                          setState(() => _notificationsEnabled = v),
                    ),
                    _divider(),
                    _switchTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      value: _darkModeEnabled,
                      onChanged: (v) => setState(() => _darkModeEnabled = v),
                    ),
                    _divider(),
                    _switchTile(
                      icon: Icons.fingerprint,
                      title: 'Biometric Login',
                      value: _biometricEnabled,
                      onChanged: (v) => setState(() => _biometricEnabled = v),
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // Order History
                  Text(
                    'Recent Orders',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _settingsCard(
                    children: _orderHistory
                        .map((order) => Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: AppColors.cream,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Center(
                                      child: Text('☕',
                                          style: TextStyle(fontSize: 22)),
                                    ),
                                  ),
                                  title: Text(
                                    order['items'],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: AppColors.darkBrown,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${order['date']} • ${order['id']}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        order['total'],
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.darkBrown,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color:
                                              AppColors.success.withValues(alpha: 0.15),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          order['status'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            color: AppColors.success,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (order != _orderHistory.last) _divider(),
                              ],
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  // Support & Logout
                  _settingsCard(children: [
                    _settingsTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    _divider(),
                    _settingsTile(
                      icon: Icons.star_outline,
                      title: 'Rate the App',
                      onTap: () {},
                    ),
                    _divider(),
                    _settingsTile(
                      icon: Icons.logout,
                      title: 'Logout',
                      color: AppColors.error,
                      onTap: () => _showLogoutDialog(context),
                    ),
                  ]),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightBrown.withValues(alpha: 0.2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.gold, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.darkBrown,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingsCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightBrown.withValues(alpha: 0.15),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color ?? AppColors.mediumBrown),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: color ?? AppColors.darkBrown,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(Icons.chevron_right,
          color: color ?? AppColors.lightBrown, size: 20),
      onTap: onTap,
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.mediumBrown),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.darkBrown,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: AppColors.darkBrown,
      ),
    );
  }

  Widget _divider() =>
      const Divider(color: AppColors.lightBrown, height: 8, thickness: 0.5);

  void _showEditProfileDialog(BuildContext context) {
    final nameController =
        TextEditingController(text: 'Muhammad Qasim');
    final emailController =
        TextEditingController(text: 'm.qasim@email.com');
    final phoneController = TextEditingController(text: '+92 300 1234567');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon:
                    Icon(Icons.person_outline, color: AppColors.mediumBrown),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon:
                    Icon(Icons.email_outlined, color: AppColors.mediumBrown),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon:
                    Icon(Icons.phone_outlined, color: AppColors.mediumBrown),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: AppColors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Profile updated! ✅',
                      style: GoogleFonts.poppins()),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Logout?',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.poppins(color: AppColors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel',
                style: GoogleFonts.poppins(color: AppColors.grey)),
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
