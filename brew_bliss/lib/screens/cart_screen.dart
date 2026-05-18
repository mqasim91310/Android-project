// lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import 'order_confirmation_screen.dart';

class CartScreen extends StatefulWidget {
  final CartProvider cartProvider;

  const CartScreen({super.key, required this.cartProvider});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPayment = 'Card';
  final List<String> _paymentMethods = ['Card', 'PayPal', 'Cash'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: false,
        actions: [
          if (widget.cartProvider.items.isNotEmpty)
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      'Clear Cart?',
                      style: GoogleFonts.playfairDisplay(
                        color: AppColors.darkBrown,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to remove all items?',
                      style: GoogleFonts.poppins(color: AppColors.grey),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(color: AppColors.grey),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                        ),
                        onPressed: () {
                          setState(() => widget.cartProvider.clearCart());
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Clear',
                style: GoogleFonts.poppins(color: AppColors.error),
              ),
            ),
        ],
      ),
      body: widget.cartProvider.items.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                // Cart Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: widget.cartProvider.items.length,
                    itemBuilder: (context, index) {
                      final cartItem = widget.cartProvider.items[index];
                      return Dismissible(
                        key: Key('${cartItem.item.id}-$index'),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          setState(() => widget.cartProvider.removeItem(index));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${cartItem.item.name} removed',
                                style: GoogleFonts.poppins(),
                              ),
                              backgroundColor: AppColors.error,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.delete, color: AppColors.white),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightBrown.withValues(alpha: 0.2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Emoji
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  color: AppColors.cream,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: Text(
                                    cartItem.item.emoji,
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // Info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.item.name,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkBrown,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${cartItem.selectedSize} • ${cartItem.selectedMilk}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: AppColors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${cartItem.totalPrice.toStringAsFixed(2)}',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkBrown,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Quantity controls
                              Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.lightBrown),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.remove, size: 16),
                                      color: AppColors.mediumBrown,
                                      onPressed: () {
                                        setState(() => widget.cartProvider
                                            .decrementQuantity(index));
                                      },
                                    ),
                                    Text(
                                      '${cartItem.quantity}',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.darkBrown,
                                      ),
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(
                                          minWidth: 32, minHeight: 32),
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.add, size: 16),
                                      color: AppColors.mediumBrown,
                                      onPressed: () {
                                        setState(() => widget.cartProvider
                                            .incrementQuantity(index));
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Order Summary + Checkout
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.lightBrown.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        // Payment Method
                        Row(
                          children: [
                            Text(
                              'Payment: ',
                              style: GoogleFonts.poppins(
                                color: AppColors.grey,
                                fontSize: 14,
                              ),
                            ),
                            ..._paymentMethods.map((method) {
                              final isSelected = _selectedPayment == method;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedPayment = method),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.darkBrown
                                        : AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    method,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.grey,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Divider(color: AppColors.lightBrown),
                        const SizedBox(height: 12),

                        // Price breakdown
                        _priceRow(
                            'Subtotal',
                            '\$${widget.cartProvider.subtotal.toStringAsFixed(2)}'),
                        const SizedBox(height: 6),
                        _priceRow(
                            'Tax (8%)',
                            '\$${widget.cartProvider.tax.toStringAsFixed(2)}'),
                        const SizedBox(height: 6),
                        _priceRow(
                          'Total',
                          '\$${widget.cartProvider.total.toStringAsFixed(2)}',
                          isBold: true,
                        ),

                        const SizedBox(height: 16),

                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => OrderConfirmationScreen(
                                    total: widget.cartProvider.total,
                                    itemCount: widget.cartProvider.itemCount,
                                    cartProvider: widget.cartProvider,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Place Order • \$${widget.cartProvider.total.toStringAsFixed(2)}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 80)),
          const SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              color: AppColors.darkBrown,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some delicious drinks!',
            style: GoogleFonts.poppins(color: AppColors.grey),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: isBold ? AppColors.darkBrown : AppColors.grey,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: isBold ? AppColors.darkBrown : AppColors.grey,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 14,
          ),
        ),
      ],
    );
  }
}
