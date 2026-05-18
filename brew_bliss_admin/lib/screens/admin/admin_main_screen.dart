// lib/screens/admin/admin_main_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../widgets/admin_widgets.dart';
import 'dashboard_screen.dart';
import 'orders_screen.dart';
import 'menu_items_screen.dart';
import 'customers_screen.dart';
import 'analytics_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});
  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _selectedIndex = 0;

  static const List<String> _titles = [
    'Dashboard',
    'Orders',
    'Menu Items',
    'Customers',
    'Analytics',
    'Notifications',
    'Settings',
  ];

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(onNavigate: (i) => setState(() => _selectedIndex = i)),
      const OrdersScreen(),
      const MenuItemsScreen(),
      const CustomersScreen(),
      const AnalyticsScreen(),
      const NotificationsScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.lightGrey,
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        elevation: 0,
        shadowColor: AdminColors.lightBrown.withOpacity(0.2),
        actions: [
          // Notification bell
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () => setState(() => _selectedIndex = 5),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AdminColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // Profile avatar
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = 6),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AdminColors.darkBrown,
                child: Text(
                  'MQ',
                  style: GoogleFonts.poppins(
                    color: AdminColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: AdminDrawer(
        selectedIndex: _selectedIndex,
        onSelect: (i) => setState(() => _selectedIndex = i),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
