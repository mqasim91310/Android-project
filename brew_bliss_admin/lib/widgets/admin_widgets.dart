// lib/widgets/admin_widgets.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/admin_theme.dart';

// ── Stat Card ────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? subtitle;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AdminColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AdminColors.lightBrown.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              if (subtitle != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AdminColors.success.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    subtitle!,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AdminColors.success,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AdminColors.darkBrown,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AdminColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Status Badge ─────────────────────────────────────────────
class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Color get _color {
    switch (status) {
      case 'Completed': return AdminColors.success;
      case 'Brewing':   return AdminColors.info;
      case 'Pending':   return AdminColors.warning;
      case 'Ready':     return AdminColors.gold;
      case 'Cancelled': return AdminColors.error;
      case 'Active':    return AdminColors.success;
      case 'Inactive':  return AdminColors.grey;
      case 'VIP':       return AdminColors.gold;
      default:          return AdminColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.4)),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 11,
          color: _color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AdminColors.darkBrown,
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(
              actionLabel!,
              style: GoogleFonts.poppins(
                color: AdminColors.mediumBrown,
                fontSize: 13,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Admin Drawer ──────────────────────────────────────────────
class AdminDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const AdminDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const List<Map<String, dynamic>> _items = [
    {'icon': Icons.dashboard_outlined,      'activeIcon': Icons.dashboard,           'label': 'Dashboard'},
    {'icon': Icons.receipt_long_outlined,   'activeIcon': Icons.receipt_long,        'label': 'Orders'},
    {'icon': Icons.menu_book_outlined,      'activeIcon': Icons.menu_book,           'label': 'Menu Items'},
    {'icon': Icons.people_outline,          'activeIcon': Icons.people,              'label': 'Customers'},
    {'icon': Icons.bar_chart_outlined,      'activeIcon': Icons.bar_chart,           'label': 'Analytics'},
    {'icon': Icons.notifications_outlined,  'activeIcon': Icons.notifications,       'label': 'Notifications'},
    {'icon': Icons.settings_outlined,       'activeIcon': Icons.settings,            'label': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AdminColors.sidebar,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
            color: AdminColors.sidebar,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AdminColors.gold.withOpacity(0.2),
                    border: Border.all(color: AdminColors.gold, width: 2),
                  ),
                  child: const Center(
                    child: Text('☕', style: TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Brew & Bliss',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.white,
                  ),
                ),
                Text(
                  'Admin Panel',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AdminColors.gold,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white12, height: 1),
          const SizedBox(height: 8),

          // Nav Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final item = _items[i];
                final isSelected = selectedIndex == i;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AdminColors.gold.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      isSelected ? item['activeIcon'] : item['icon'],
                      color: isSelected ? AdminColors.gold : AdminColors.lightBrown,
                      size: 22,
                    ),
                    title: Text(
                      item['label'],
                      style: GoogleFonts.poppins(
                        color: isSelected ? AdminColors.gold : AdminColors.lightBrown,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                    onTap: () {
                      onSelect(i);
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),

          // Admin info
          const Divider(color: Colors.white12, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white12,
                  child: Icon(Icons.person, color: AdminColors.lightBrown, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Muhammad Qasim',
                        style: GoogleFonts.poppins(
                          color: AdminColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Super Admin',
                        style: GoogleFonts.poppins(
                          color: AdminColors.lightBrown,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
