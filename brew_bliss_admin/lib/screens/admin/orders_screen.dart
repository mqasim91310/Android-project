// lib/screens/admin/orders_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../data/admin_dummy_data.dart';
import '../../models/admin_models.dart';
import '../../widgets/admin_widgets.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<OrderModel> _orders;
  String _search = '';

  final List<String> _tabs = ['All', 'Pending', 'Brewing', 'Ready', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _orders = List.from(AdminDummyData.orders);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<OrderModel> _filtered(String tab) {
    return _orders.where((o) {
      final matchTab = tab == 'All' || o.status == tab;
      final matchSearch = _search.isEmpty ||
          o.id.toLowerCase().contains(_search.toLowerCase()) ||
          o.customer.toLowerCase().contains(_search.toLowerCase());
      return matchTab && matchSearch;
    }).toList();
  }

  void _updateStatus(OrderModel order, String newStatus) {
    setState(() => order.status = newStatus);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${order.id} → $newStatus',
          style: GoogleFonts.poppins()),
      backgroundColor: AdminColors.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _showOrderDetail(OrderModel order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AdminColors.lightBrown,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order ${order.id}',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AdminColors.darkBrown)),
                StatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: 16),
            _detailRow('Customer', order.customer),
            _detailRow('Items', order.items),
            _detailRow('Total', '\$${order.total.toStringAsFixed(2)}'),
            _detailRow('Payment', order.payMethod),
            _detailRow('Time', order.time),
            const SizedBox(height: 20),
            Text('Update Status',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AdminColors.darkBrown)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Pending', 'Brewing', 'Ready', 'Completed', 'Cancelled']
                  .map((s) => ChoiceChip(
                        label: Text(s),
                        selected: order.status == s,
                        onSelected: (_) {
                          _updateStatus(order, s);
                          Navigator.pop(context);
                        },
                        selectedColor: AdminColors.darkBrown,
                        labelStyle: GoogleFonts.poppins(
                          color: order.status == s
                              ? AdminColors.white
                              : AdminColors.mediumBrown,
                          fontSize: 12,
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(label,
                style: GoogleFonts.poppins(
                    color: AdminColors.grey, fontSize: 13)),
          ),
          Expanded(
            child: Text(value,
                style: GoogleFonts.poppins(
                    color: AdminColors.darkBrown,
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Container(
          color: AdminColors.white,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: TextField(
            onChanged: (v) => setState(() => _search = v),
            decoration: InputDecoration(
              hintText: 'Search orders or customers...',
              hintStyle: GoogleFonts.poppins(color: AdminColors.grey, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: AdminColors.mediumBrown),
            ),
          ),
        ),
        // Tab bar
        Container(
          color: AdminColors.white,
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
            unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
            labelColor: AdminColors.darkBrown,
            unselectedLabelColor: AdminColors.grey,
            indicatorColor: AdminColors.darkBrown,
            tabs: _tabs.map((t) => Tab(text: t)).toList(),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: _tabs.map((tab) {
              final list = _filtered(tab);
              if (list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.receipt_long,
                          size: 60, color: AdminColors.lightBrown),
                      const SizedBox(height: 12),
                      Text('No orders found',
                          style: GoogleFonts.poppins(
                              color: AdminColors.grey, fontSize: 16)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  final o = list[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AdminColors.cream,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text('☕', style: TextStyle(fontSize: 24)),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(o.id,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AdminColors.darkBrown)),
                          StatusBadge(status: o.status),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(o.customer,
                              style: GoogleFonts.poppins(
                                  color: AdminColors.mediumBrown, fontSize: 12)),
                          Text(o.items,
                              style: GoogleFonts.poppins(
                                  color: AdminColors.grey, fontSize: 11)),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('\$${o.total.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: AdminColors.darkBrown,
                                      fontSize: 15)),
                              Text('${o.payMethod} • ${o.time}',
                                  style: GoogleFonts.poppins(
                                      color: AdminColors.grey, fontSize: 11)),
                            ],
                          ),
                        ],
                      ),
                      onTap: () => _showOrderDetail(o),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
