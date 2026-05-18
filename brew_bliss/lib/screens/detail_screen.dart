// lib/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/coffee_item.dart';
import '../providers/cart_provider.dart';

class DetailScreen extends StatefulWidget {
  final CoffeeItem item;
  final CartProvider cartProvider;

  const DetailScreen({
    super.key,
    required this.item,
    required this.cartProvider,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _selectedSize = 'Medium';
  String _selectedMilk = 'Whole';
  int _quantity = 1;
  double _sweetness = 0.5;
  bool _extraShot = false;
  bool _iceOnSide = false;

  double get _totalPrice =>
      widget.item.price * _quantity + (_extraShot ? 0.75 : 0);

  @override
  void initState() {
    super.initState();
    if (widget.item.sizes.isNotEmpty) {
      _selectedSize = widget.item.sizes.contains('Medium')
          ? 'Medium'
          : widget.item.sizes.first;
    }
    if (widget.item.milkOptions.isNotEmpty) {
      _selectedMilk = widget.item.milkOptions.contains('Whole')
          ? 'Whole'
          : widget.item.milkOptions.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(
        slivers: [
          // Hero App Bar
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.darkBrown,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.white),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: AppColors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to favorites! ❤️',
                            style: GoogleFonts.poppins()),
                        backgroundColor: AppColors.error,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [AppColors.mediumBrown, AppColors.darkBrown],
                    radius: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      widget.item.emoji,
                      style: const TextStyle(fontSize: 100),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkBrown,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: AppColors.gold, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.item.rating}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                color: AppColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Calories + Category badges
                  Row(
                    children: [
                      _badge('${widget.item.calories} kcal', Icons.local_fire_department),
                      const SizedBox(width: 8),
                      _badge(widget.item.category, Icons.category_outlined),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    widget.item.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.grey,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Divider(color: AppColors.lightBrown),
                  const SizedBox(height: 16),

                  // Size Selection
                  if (widget.item.sizes.isNotEmpty) ...[
                    Text(
                      'Choose Size',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      children: widget.item.sizes.map((size) {
                        final isSelected = _selectedSize == size;
                        return ChoiceChip(
                          label: Text(size),
                          selected: isSelected,
                          onSelected: (_) =>
                              setState(() => _selectedSize = size),
                          selectedColor: AppColors.darkBrown,
                          labelStyle: GoogleFonts.poppins(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.mediumBrown,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          backgroundColor: AppColors.white,
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.darkBrown
                                : AppColors.lightBrown,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Milk Selection
                  if (widget.item.milkOptions.isNotEmpty) ...[
                    Text(
                      'Choose Milk',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: widget.item.milkOptions.map((milk) {
                        final isSelected = _selectedMilk == milk;
                        return ChoiceChip(
                          label: Text(milk),
                          selected: isSelected,
                          onSelected: (_) =>
                              setState(() => _selectedMilk = milk),
                          selectedColor: AppColors.darkBrown,
                          labelStyle: GoogleFonts.poppins(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.mediumBrown,
                          ),
                          backgroundColor: AppColors.white,
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.darkBrown
                                : AppColors.lightBrown,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Sweetness
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sweetness Level',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      Text(
                        _sweetness == 0
                            ? 'None'
                            : _sweetness <= 0.25
                                ? 'Light'
                                : _sweetness <= 0.5
                                    ? 'Medium'
                                    : _sweetness <= 0.75
                                        ? 'Sweet'
                                        : 'Extra Sweet',
                        style: GoogleFonts.poppins(
                          color: AppColors.gold,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _sweetness,
                    onChanged: (val) => setState(() => _sweetness = val),
                    activeColor: AppColors.darkBrown,
                    inactiveColor: AppColors.lightBrown,
                  ),

                  const SizedBox(height: 16),

                  // Add-ons
                  Text(
                    'Add-ons',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.darkBrown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Extra Espresso Shot (+\$0.75)',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.mediumBrown,
                      ),
                    ),
                    value: _extraShot,
                    onChanged: (val) => setState(() => _extraShot = val),
                    activeThumbColor: AppColors.darkBrown,
                  ),
                  if (widget.item.category == 'Cold')
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Ice on Side',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.mediumBrown,
                        ),
                      ),
                      value: _iceOnSide,
                      onChanged: (val) => setState(() => _iceOnSide = val),
                      activeThumbColor: AppColors.darkBrown,
                    ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.lightBrown.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Quantity
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightBrown),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: AppColors.mediumBrown),
                      onPressed: () {
                        if (_quantity > 1) setState(() => _quantity--);
                      },
                    ),
                    Text(
                      '$_quantity',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: AppColors.mediumBrown),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // Add to Cart Button
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    for (int i = 0; i < _quantity; i++) {
                      widget.cartProvider.addItem(
                        widget.item,
                        size: _selectedSize,
                        milk: _selectedMilk,
                      );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.item.name} added to cart! 🎉',
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: AppColors.success,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Add to Cart • \$${_totalPrice.toStringAsFixed(2)}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightBrown.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.mediumBrown),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.mediumBrown,
            ),
          ),
        ],
      ),
    );
  }
}
