// lib/screens/admin/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import 'admin_login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _emailNotifs    = true;
  bool _pushNotifs     = true;
  bool _orderAlerts    = true;
  bool _lowStockAlerts = true;
  bool _twoFactor      = false;
  bool _darkMode       = false;
  String _currency     = 'USD (\$)';
  String _language     = 'English';
  double _taxRate      = 8.0;

  final _shopNameCtrl  = TextEditingController(text: 'Brew & Bliss');
  final _shopEmailCtrl = TextEditingController(text: 'hello@brewbliss.com');
  final _shopPhoneCtrl = TextEditingController(text: '+92 300 0000000');
  final _shopAddrCtrl  = TextEditingController(text: 'Main Branch, Lahore');

  @override
  void dispose() {
    _shopNameCtrl.dispose();
    _shopEmailCtrl.dispose();
    _shopPhoneCtrl.dispose();
    _shopAddrCtrl.dispose();
    super.dispose();
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Settings saved successfully! ✅',
          style: GoogleFonts.poppins()),
      backgroundColor: AdminColors.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Admin profile card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AdminColors.darkBrown, AdminColors.mediumBrown],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AdminColors.gold.withOpacity(0.2),
                  child: Text('MQ',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AdminColors.gold)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Muhammad Qasim',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AdminColors.white)),
                      Text('Super Admin',
                          style: GoogleFonts.poppins(
                              color: AdminColors.gold, fontSize: 13)),
                      Text('admin@brewbliss.com',
                          style: GoogleFonts.poppins(
                              color: AdminColors.lightBrown, fontSize: 12)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: AdminColors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Shop Info
          _sectionTitle('Shop Information'),
          _card(children: [
            _field('Shop Name', _shopNameCtrl, Icons.store),
            const SizedBox(height: 12),
            _field('Contact Email', _shopEmailCtrl, Icons.email_outlined),
            const SizedBox(height: 12),
            _field('Phone Number', _shopPhoneCtrl, Icons.phone_outlined),
            const SizedBox(height: 12),
            _field('Address', _shopAddrCtrl, Icons.location_on_outlined),
          ]),

          const SizedBox(height: 20),

          // Notifications
          _sectionTitle('Notification Settings'),
          _card(children: [
            _switchRow('Email Notifications', _emailNotifs,
                (v) => setState(() => _emailNotifs = v)),
            _divider(),
            _switchRow('Push Notifications', _pushNotifs,
                (v) => setState(() => _pushNotifs = v)),
            _divider(),
            _switchRow('New Order Alerts', _orderAlerts,
                (v) => setState(() => _orderAlerts = v)),
            _divider(),
            _switchRow('Low Stock Alerts', _lowStockAlerts,
                (v) => setState(() => _lowStockAlerts = v)),
          ]),

          const SizedBox(height: 20),

          // Security
          _sectionTitle('Security'),
          _card(children: [
            _switchRow('Two-Factor Authentication', _twoFactor,
                (v) => setState(() => _twoFactor = v)),
            _divider(),
            _tapRow('Change Password', Icons.lock_outline, () {}),
            _divider(),
            _tapRow('Active Sessions', Icons.devices, () {}),
          ]),

          const SizedBox(height: 20),

          // App Preferences
          _sectionTitle('App Preferences'),
          _card(children: [
            _switchRow('Dark Mode', _darkMode,
                (v) => setState(() => _darkMode = v)),
            _divider(),
            _dropdownRow('Currency', _currency, ['USD (\$)', 'EUR (€)', 'GBP (£)', 'PKR (₨)'],
                (v) => setState(() => _currency = v!)),
            _divider(),
            _dropdownRow('Language', _language, ['English', 'Urdu', 'Arabic'],
                (v) => setState(() => _language = v!)),
            _divider(),
            // Tax rate slider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax Rate',
                          style: GoogleFonts.poppins(
                              color: AdminColors.darkBrown,
                              fontSize: 14,
                              fontWeight: FontWeight.w500)),
                      Text('${_taxRate.toStringAsFixed(1)}%',
                          style: GoogleFonts.poppins(
                              color: AdminColors.gold,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Slider(
                    value: _taxRate,
                    min: 0,
                    max: 20,
                    divisions: 40,
                    activeColor: AdminColors.darkBrown,
                    inactiveColor: AdminColors.lightBrown,
                    onChanged: (v) => setState(() => _taxRate = v),
                  ),
                ],
              ),
            ),
          ]),

          const SizedBox(height: 20),

          // About
          _sectionTitle('About'),
          _card(children: [
            _tapRow('Privacy Policy', Icons.privacy_tip_outlined, () {}),
            _divider(),
            _tapRow('Terms of Service', Icons.description_outlined, () {}),
            _divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline, color: AdminColors.mediumBrown),
              title: Text('App Version',
                  style: GoogleFonts.poppins(
                      color: AdminColors.darkBrown,
                      fontWeight: FontWeight.w500,
                      fontSize: 14)),
              trailing: Text('v1.0.0',
                  style: GoogleFonts.poppins(
                      color: AdminColors.grey, fontSize: 13)),
            ),
          ]),

          const SizedBox(height: 20),

          // Save + Logout
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _saveSettings,
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Settings'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AdminColors.error,
                side: const BorderSide(color: AdminColors.error),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout),
              label: Text('Logout',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  title: Text('Logout?',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: AdminColors.darkBrown)),
                  content: Text('Are you sure you want to logout?',
                      style: GoogleFonts.poppins(color: AdminColors.grey)),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel',
                            style:
                                GoogleFonts.poppins(color: AdminColors.grey))),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AdminColors.error),
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const AdminLoginScreen()),
                        (_) => false,
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(title,
            style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AdminColors.darkBrown)),
      );

  Widget _card({required List<Widget> children}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AdminColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AdminColors.lightBrown.withOpacity(0.3)),
        ),
        child: Column(children: children),
      );

  Widget _field(String label, TextEditingController ctrl, IconData icon) =>
      TextField(
        controller: ctrl,
        style: GoogleFonts.poppins(fontSize: 14, color: AdminColors.darkBrown),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AdminColors.mediumBrown, size: 20),
        ),
      );

  Widget _switchRow(String label, bool value, ValueChanged<bool> onChanged) =>
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label,
            style: GoogleFonts.poppins(
                color: AdminColors.darkBrown,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        value: value,
        onChanged: onChanged,
        activeColor: AdminColors.darkBrown,
      );

  Widget _tapRow(String label, IconData icon, VoidCallback onTap) => ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AdminColors.mediumBrown, size: 22),
        title: Text(label,
            style: GoogleFonts.poppins(
                color: AdminColors.darkBrown,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: AdminColors.lightBrown),
        onTap: onTap,
      );

  Widget _dropdownRow(String label, String value, List<String> options,
          ValueChanged<String?> onChanged) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Expanded(
            child: Text(label,
                style: GoogleFonts.poppins(
                    color: AdminColors.darkBrown,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            style: GoogleFonts.poppins(
                color: AdminColors.mediumBrown, fontSize: 13),
            items: options
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: onChanged,
          ),
        ]),
      );

  Widget _divider() =>
      const Divider(color: AdminColors.lightBrown, height: 4, thickness: 0.5);
}
