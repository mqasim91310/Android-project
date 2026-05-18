// lib/screens/admin/customers_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../data/admin_dummy_data.dart';
import '../../models/admin_models.dart';
import '../../widgets/admin_widgets.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});
  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late List<Customer> _customers;
  String _search = '';
  String _filterStatus = 'All';

  @override
  void initState() {
    super.initState();
    _customers = List.from(AdminDummyData.customers);
  }

  List<Customer> get _filtered => _customers.where((c) {
        final statusOk =
            _filterStatus == 'All' || c.status == _filterStatus;
        final searchOk = _search.isEmpty ||
            c.name.toLowerCase().contains(_search.toLowerCase()) ||
            c.email.toLowerCase().contains(_search.toLowerCase());
        return statusOk && searchOk;
      }).toList();

  void _showCustomerDetail(Customer c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AdminColors.lightBrown,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Avatar
            CircleAvatar(
              radius: 36,
              backgroundColor: AdminColors.darkBrown,
              child: Text(
                c.name[0],
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AdminColors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(c.name,
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AdminColors.darkBrown)),
            StatusBadge(status: c.status),
            const SizedBox(height: 20),
            // Stats row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _miniStat('Orders', '${c.orders}', Icons.receipt),
                _miniStat('Spent', '\$${c.totalSpent.toStringAsFixed(0)}', Icons.attach_money),
                _miniStat('Joined', c.joined.split(',')[0], Icons.calendar_today),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: AdminColors.lightBrown),
            _infoRow(Icons.email_outlined, c.email),
            _infoRow(Icons.phone_outlined, c.phone),
            _infoRow(Icons.calendar_month_outlined, 'Joined: ${c.joined}'),
            const SizedBox(height: 16),
            // Change status
            Row(
              children: [
                Text('Status: ',
                    style: GoogleFonts.poppins(
                        color: AdminColors.grey, fontSize: 13)),
                ...[
                  'Active', 'Inactive', 'VIP'
                ].map((s) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(s, style: GoogleFonts.poppins(fontSize: 12)),
                        selected: c.status == s,
                        onSelected: (_) {
                          setState(() => c.status = s);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${c.name} → $s',
                                style: GoogleFonts.poppins()),
                            backgroundColor: AdminColors.success,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ));
                        },
                        selectedColor: AdminColors.darkBrown,
                        labelStyle: GoogleFonts.poppins(
                          color: c.status == s
                              ? AdminColors.white
                              : AdminColors.mediumBrown,
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(String label, String value, IconData icon) {
    return Column(children: [
      Icon(icon, color: AdminColors.gold, size: 20),
      const SizedBox(height: 4),
      Text(value,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AdminColors.darkBrown)),
      Text(label,
          style: GoogleFonts.poppins(fontSize: 11, color: AdminColors.grey)),
    ]);
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Icon(icon, size: 18, color: AdminColors.mediumBrown),
        const SizedBox(width: 10),
        Text(text,
            style: GoogleFonts.poppins(
                color: AdminColors.darkBrown, fontSize: 13)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AdminColors.white,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Column(
            children: [
              TextField(
                onChanged: (v) => setState(() => _search = v),
                decoration: InputDecoration(
                  hintText: 'Search customers...',
                  hintStyle: GoogleFonts.poppins(
                      color: AdminColors.grey, fontSize: 13),
                  prefixIcon: const Icon(Icons.search,
                      color: AdminColors.mediumBrown),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Active', 'VIP', 'Inactive'].map((s) {
                    final sel = _filterStatus == s;
                    return GestureDetector(
                      onTap: () => setState(() => _filterStatus = s),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: sel
                              ? AdminColors.darkBrown
                              : AdminColors.lightGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(s,
                            style: GoogleFonts.poppins(
                              color: sel
                                  ? AdminColors.white
                                  : AdminColors.grey,
                              fontWeight: sel
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              fontSize: 13,
                            )),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),

        // Summary chips
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(children: [
            _summaryChip('Total', '${_customers.length}', AdminColors.darkBrown),
            const SizedBox(width: 8),
            _summaryChip('VIP', '${_customers.where((c) => c.status == 'VIP').length}', AdminColors.gold),
            const SizedBox(width: 8),
            _summaryChip('Inactive', '${_customers.where((c) => c.status == 'Inactive').length}', AdminColors.grey),
          ]),
        ),

        const SizedBox(height: 8),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            itemCount: _filtered.length,
            itemBuilder: (ctx, i) {
              final c = _filtered[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: AdminColors.darkBrown,
                    child: Text(
                      c.name[0],
                      style: GoogleFonts.poppins(
                        color: AdminColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(c.name,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: AdminColors.darkBrown)),
                      StatusBadge(status: c.status),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(c.email,
                          style: GoogleFonts.poppins(
                              fontSize: 12, color: AdminColors.grey)),
                      const SizedBox(height: 4),
                      Row(children: [
                        const Icon(Icons.receipt_long,
                            size: 13, color: AdminColors.mediumBrown),
                        Text(' ${c.orders} orders',
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: AdminColors.mediumBrown)),
                        const SizedBox(width: 12),
                        const Icon(Icons.attach_money,
                            size: 13, color: AdminColors.mediumBrown),
                        Text(
                            '\$${c.totalSpent.toStringAsFixed(2)} spent',
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AdminColors.mediumBrown)),
                      ]),
                    ],
                  ),
                  onTap: () => _showCustomerDetail(c),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _summaryChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text('$label: $value',
          style: GoogleFonts.poppins(
              color: color, fontWeight: FontWeight.w600, fontSize: 12)),
    );
  }
}
