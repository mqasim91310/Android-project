// lib/screens/admin/analytics_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../data/admin_dummy_data.dart';
import '../../widgets/admin_widgets.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _period = 'Weekly';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stats = AdminDummyData.dashboardStats;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period selector
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Row(
              children: ['Daily', 'Weekly', 'Monthly'].map((p) {
                final sel = _period == p;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _period = p),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: sel ? AdminColors.darkBrown : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(p,
                            style: GoogleFonts.poppins(
                              color: sel ? AdminColors.white : AdminColors.grey,
                              fontWeight:
                                  sel ? FontWeight.w600 : FontWeight.normal,
                              fontSize: 13,
                            )),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),

          // Revenue Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.6,
            children: [
              StatCard(
                title: _period == 'Daily'
                    ? "Today's Revenue"
                    : _period == 'Weekly'
                        ? 'Weekly Revenue'
                        : 'Monthly Revenue',
                value: _period == 'Daily'
                    ? '\$${stats['todayRevenue']}'
                    : _period == 'Weekly'
                        ? '\$${stats['weekRevenue']}'
                        : '\$${stats['monthRevenue']}',
                icon: Icons.monetization_on,
                color: AdminColors.success,
                subtitle: '+12%',
              ),
              StatCard(
                title: 'Avg Order Value',
                value: '\$${stats['avgOrderValue']}',
                icon: Icons.analytics,
                color: AdminColors.info,
              ),
              StatCard(
                title: 'Top Item',
                value: '${stats['topItem']}',
                icon: Icons.star,
                color: AdminColors.gold,
              ),
              StatCard(
                title: 'Total Orders',
                value: _period == 'Daily'
                    ? '${stats['totalOrders']}'
                    : _period == 'Weekly'
                        ? '68'
                        : '243',
                icon: Icons.receipt,
                color: AdminColors.warning,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Bar Chart
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Revenue Trend'),
                const SizedBox(height: 4),
                Text(
                  _period == 'Weekly'
                      ? 'Mon – Sun this week'
                      : _period == 'Monthly'
                          ? 'Week 1 – Week 4'
                          : 'Hourly today',
                  style: GoogleFonts.poppins(
                      color: AdminColors.grey, fontSize: 12),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        List.generate(7, (i) {
                      final val = AdminDummyData.weeklySales[i];
                      final maxVal = AdminDummyData.weeklySales
                          .reduce((a, b) => a > b ? a : b);
                      final barH = (val / maxVal) * 130;
                      final isHighest = val == maxVal;
                      return Tooltip(
                        message: '\$${val.toInt()}',
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isHighest)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AdminColors.gold.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Peak',
                                    style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        color: AdminColors.gold,
                                        fontWeight: FontWeight.bold)),
                              ),
                            const SizedBox(height: 4),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              width: 30,
                              height: barH,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isHighest
                                      ? [AdminColors.gold, const Color(0xFFF59E0B)]
                                      : [
                                          AdminColors.darkBrown,
                                          AdminColors.mediumBrown.withOpacity(0.6),
                                        ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(8)),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(AdminDummyData.weekDays[i],
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: isHighest
                                        ? AdminColors.darkBrown
                                        : AdminColors.grey,
                                    fontWeight: isHighest
                                        ? FontWeight.bold
                                        : FontWeight.normal)),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Category Donut (manual)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Sales by Category'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    // Manual pie visual
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CustomPaint(
                        painter: _PiePainter(),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        children: [
                          _legendItem('Hot Drinks',   45, AdminColors.darkBrown),
                          const SizedBox(height: 12),
                          _legendItem('Cold Drinks',  35, AdminColors.info),
                          const SizedBox(height: 12),
                          _legendItem('Snacks',       20, AdminColors.gold),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Top items table
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AdminColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AdminColors.lightBrown.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Top Performing Items'),
                const SizedBox(height: 12),
                // Table header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AdminColors.cream,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: Text('Item', style: _hStyle())),
                      Expanded(flex: 2, child: Text('Orders', style: _hStyle())),
                      Expanded(flex: 2, child: Text('Revenue', style: _hStyle())),
                      Expanded(flex: 2, child: Text('Rating', style: _hStyle())),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ...AdminDummyData.menuItems
                    .toList()
                    .take(6)
                    .map((item) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(children: [
                                  Text(item.emoji,
                                      style: const TextStyle(fontSize: 18)),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(item.name,
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: AdminColors.darkBrown,
                                            fontWeight: FontWeight.w500),
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ]),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text('${item.orders}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: AdminColors.mediumBrown)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                    '\$${(item.price * item.orders).toStringAsFixed(0)}',
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: AdminColors.darkBrown,
                                        fontWeight: FontWeight.w600)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(children: [
                                  const Icon(Icons.star,
                                      color: AdminColors.gold, size: 14),
                                  Text('${item.rating}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: AdminColors.grey)),
                                ]),
                              ),
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

  TextStyle _hStyle() => GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: 12,
      color: AdminColors.darkBrown);

  Widget _legendItem(String label, int percent, Color color) {
    return Row(children: [
      Container(
          width: 12,
          height: 12,
          decoration:
              BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
      const SizedBox(width: 8),
      Expanded(
        child: Text(label,
            style: GoogleFonts.poppins(
                fontSize: 13, color: AdminColors.darkBrown)),
      ),
      Text('$percent%',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13)),
    ]);
  }
}

class _PiePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 20.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Hot: 45% = 162°
    paint.color = AdminColors.darkBrown;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -1.5708, // -90°
      2.827,   // 162°
      false,
      paint,
    );
    // Cold: 35% = 126°
    paint.color = AdminColors.info;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      1.2566,
      2.199,
      false,
      paint,
    );
    // Snacks: 20% = 72°
    paint.color = AdminColors.gold;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      3.4558,
      1.2566,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
