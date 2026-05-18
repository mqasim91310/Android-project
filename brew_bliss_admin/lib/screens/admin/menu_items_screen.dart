// lib/screens/admin/menu_items_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../data/admin_dummy_data.dart';
import '../../models/admin_models.dart';
import '../../widgets/admin_widgets.dart';

class MenuItemsScreen extends StatefulWidget {
  const MenuItemsScreen({super.key});
  @override
  State<MenuItemsScreen> createState() => _MenuItemsScreenState();
}

class _MenuItemsScreenState extends State<MenuItemsScreen> {
  late List<MenuItem> _items;
  String _selectedCat = 'All';
  String _search = '';
  final List<String> _cats = ['All', 'Hot', 'Cold', 'Snacks'];

  @override
  void initState() {
    super.initState();
    _items = List.from(AdminDummyData.menuItems);
  }

  List<MenuItem> get _filtered => _items.where((item) {
        final catOk =
            _selectedCat == 'All' || item.category == _selectedCat;
        final searchOk = _search.isEmpty ||
            item.name.toLowerCase().contains(_search.toLowerCase());
        return catOk && searchOk;
      }).toList();

  void _showItemForm({MenuItem? item}) {
    final isEdit = item != null;
    final nameCtrl = TextEditingController(text: item?.name ?? '');
    final priceCtrl =
        TextEditingController(text: item?.price.toString() ?? '');
    final emojiCtrl = TextEditingController(text: item?.emoji ?? '');
    String selectedCat = item?.category ?? 'Hot';
    bool inStock = item?.stock ?? true;
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(isEdit ? 'Edit Item' : 'Add New Item',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: AdminColors.darkBrown)),
          content: SizedBox(
            width: 360,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Item Name',
                        prefixIcon: Icon(Icons.coffee,
                            color: AdminColors.mediumBrown),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: priceCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Price (\$)',
                        prefixIcon: Icon(Icons.attach_money,
                            color: AdminColors.mediumBrown),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid price';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emojiCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Emoji',
                        prefixIcon: Icon(Icons.emoji_food_beverage,
                            color: AdminColors.mediumBrown),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedCat,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: ['Hot', 'Cold', 'Snacks']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) =>
                          setDialogState(() => selectedCat = v ?? selectedCat),
                    ),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('In Stock',
                          style: GoogleFonts.poppins(
                              color: AdminColors.darkBrown, fontSize: 14)),
                      value: inStock,
                      onChanged: (v) => setDialogState(() => inStock = v),
                      activeColor: AdminColors.darkBrown,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Cancel',
                  style: GoogleFonts.poppins(color: AdminColors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                setState(() {
                  if (isEdit) {
                    item.name = nameCtrl.text;
                    item.price = double.parse(priceCtrl.text);
                    item.emoji = emojiCtrl.text;
                    item.category = selectedCat;
                    item.stock = inStock;
                  } else {
                    _items.add(MenuItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: nameCtrl.text,
                      category: selectedCat,
                      price: double.parse(priceCtrl.text),
                      emoji: emojiCtrl.text,
                      stock: inStock,
                      rating: 0,
                      orders: 0,
                    ));
                  }
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      isEdit ? '✅ Item updated!' : '✅ Item added!',
                      style: GoogleFonts.poppins()),
                  backgroundColor: AdminColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ));
              },
              child: Text(isEdit ? 'Save Changes' : 'Add Item'),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteItem(MenuItem item) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Item?',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: AdminColors.darkBrown)),
        content: Text('Are you sure you want to delete "${item.name}"?',
            style: GoogleFonts.poppins(color: AdminColors.grey)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel',
                  style: GoogleFonts.poppins(color: AdminColors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AdminColors.error),
            onPressed: () {
              setState(() => _items.remove(item));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('🗑️ "${item.name}" deleted',
                    style: GoogleFonts.poppins()),
                backgroundColor: AdminColors.error,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdminColors.lightGrey,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showItemForm(),
        backgroundColor: AdminColors.darkBrown,
        icon: const Icon(Icons.add, color: AdminColors.white),
        label: Text('Add Item',
            style: GoogleFonts.poppins(
                color: AdminColors.white, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          Container(
            color: AdminColors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: [
                TextField(
                  onChanged: (v) => setState(() => _search = v),
                  decoration: InputDecoration(
                    hintText: 'Search menu items...',
                    hintStyle:
                        GoogleFonts.poppins(color: AdminColors.grey, fontSize: 13),
                    prefixIcon: const Icon(Icons.search,
                        color: AdminColors.mediumBrown),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _cats.map((c) {
                      final sel = _selectedCat == c;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCat = c),
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
                          child: Text(c,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(children: [
              Text('${_filtered.length} items',
                  style: GoogleFonts.poppins(
                      color: AdminColors.grey, fontSize: 12)),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final item = _filtered[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AdminColors.cream,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:
                            Text(item.emoji, style: const TextStyle(fontSize: 26)),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(item.name,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: AdminColors.darkBrown,
                                  fontSize: 14)),
                        ),
                        StatusBadge(
                            status: item.stock ? 'Active' : 'Inactive'),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AdminColors.cream,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(item.category,
                                style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AdminColors.mediumBrown)),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.star,
                              color: AdminColors.gold, size: 13),
                          Text('${item.rating}',
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: AdminColors.grey)),
                          const SizedBox(width: 8),
                          const Icon(Icons.shopping_bag_outlined,
                              size: 13, color: AdminColors.grey),
                          Text(' ${item.orders} orders',
                              style: GoogleFonts.poppins(
                                  fontSize: 11, color: AdminColors.grey)),
                        ]),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('\$${item.price.toStringAsFixed(2)}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: AdminColors.darkBrown,
                                    fontSize: 15)),
                            Row(children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined,
                                    color: AdminColors.info, size: 20),
                                onPressed: () => _showItemForm(item: item),
                                tooltip: 'Edit',
                                constraints: const BoxConstraints(
                                    minWidth: 36, minHeight: 36),
                                padding: EdgeInsets.zero,
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(Icons.delete_outline,
                                    color: AdminColors.error, size: 20),
                                onPressed: () => _deleteItem(item),
                                tooltip: 'Delete',
                                constraints: const BoxConstraints(
                                    minWidth: 36, minHeight: 36),
                                padding: EdgeInsets.zero,
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
