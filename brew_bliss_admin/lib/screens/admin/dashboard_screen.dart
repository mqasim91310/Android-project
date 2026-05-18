// lib/screens/admin/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../data/admin_dummy_data.dart';
import '../../widgets/admin_widgets.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;
  const DashboardScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final stats  = AdminDummyData.dashboardStats;
    final orders = AdminDummyData.orders.take(5).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Morning! 👋',
                      style: GoogleFonts.poppins(
                          color: AdminColors.grey, fontSize: 13)),
                  Text('Muhammad Qasim',
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AdminColors.darkBrown)),
                ],
              ),
              Chip(
                label: Text('May 09, 2026',
                    style: GoogleFonts.poppins(
                        color: AdminColors.mediumBrown, fontSize: 12)),
                backgroundColor: AdminColors.white,
                side: BorderSide(color: AdminColors.lightBrown.withOpacity(0.5)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── 4 Stat cards ──
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.55,
            children: [
              StatCard(
                title: "Today's Revenue",
                value: '\$${stats['todayRevenue']}',
                icon: Icons.attach_money,
                color: AdminColors.success,
                subtitle: '+12%',
              ),
              StatCard(
                title: 'Total Orders',
                value: '${stats['totalOrders']}',
                icon: Icons.receipt_long,
                color: AdminColors.info,
                subtitle: 'Today',
              ),
              StatCard(
                title: 'Active Customers',
                value: '${stats['activeCustomers']}',
                icon: Icons.people,
                color: AdminColors.gold,
                subtitle: '+3 new',
              ),
              StatCard(
                title: 'Pending Orders',
                value: '${stats['pendingOrders']}',
                icon: Icons.hourglass_empty,
                color: AdminColors.warning,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Weekly bar chart (manual) ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(title: 'Weekly Revenue', actionLabel: 'This Week'),
                const SizedBox(height: 20),
                SizedBox(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(7, (i) {
                      final val = AdminDummyData.weeklySales[i];
                      final maxVal = AdminDummyData.weeklySales
                          .reduce((a, b) => a > b ? a : b);
                      final barH = (val / maxVal) * 120;
                      final isToday = i == 6;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('\$${val.toInt()}',
                              style: GoogleFonts.poppins(
                                fontSize: 9,
                                color: isToday
                                    ? AdminColors.gold
                                    : AdminColors.grey,
                                fontWeight: isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            width: 28,
                            height: barH,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isToday
                                    ? [AdminColors.gold, AdminColors.warning]
                                    : [
                                        AdminColors.darkBrown.withOpacity(0.7),
                                        AdminColors.mediumBrown.withOpacity(0.5),
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(AdminDummyData.weekDays[i],
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: isToday
                                    ? AdminColors.darkBrown
                                    : AdminColors.grey,
                                fontWeight: isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              )),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Category breakdown ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Sales by Category'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _categoryBar('Hot ☕',    45, AdminColors.darkBrown),
                    _categoryBar('Cold 🧊',   35, AdminColors.info),
                    _categoryBar('Snacks 🥐', 20, AdminColors.gold),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Recent Orders ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Recent Orders',
                  actionLabel: 'View All →',
                  onAction: () => onNavigate(1),
                ),
                const SizedBox(height: 12),
                ...orders.map((o) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AdminColors.cream,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text('☕', style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(o.id,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: AdminColors.darkBrown)),
                                Text(o.customer,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: AdminColors.grey)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('\$${o.total.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: AdminColors.darkBrown)),
                              StatusBadge(status: o.status),
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Top Selling Items ──
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Top Selling Items',
                  actionLabel: 'View Menu →',
                  onAction: () => onNavigate(2),
                ),
                const SizedBox(height: 12),
                ...AdminDummyData.menuItems
                    .toList()
                    .take(4)
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text(item.emoji,
                                  style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(item.name,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                            color: AdminColors.darkBrown)),
                                    Text('${item.orders} orders',
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: AdminColors.grey)),
                                  ],
                                ),
                              ),
                              Text('\$${item.price.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: AdminColors.darkBrown)),
                            ],
                          ),
                        )),
              ],
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _categoryBar(String label, int percent, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            Text('$percent%',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 16)),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percent / 100,
                backgroundColor: color.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 4),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 11, color: AdminColors.grey)),
          ],
        ),
      ),
    );
  }
}
