// lib/screens/order_confirmation_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final double total;
  final int itemCount;
  final CartProvider cartProvider;

  const OrderConfirmationScreen({
    super.key,
    required this.total,
    required this.itemCount,
    required this.cartProvider,
  });

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  int _currentStep = 0;

  final List<Map<String, String>> _steps = [
    {'label': 'Order Received', 'emoji': '✅'},
    {'label': 'Brewing Your Coffee', 'emoji': '☕'},
    {'label': 'Quality Check', 'emoji': '🔍'},
    {'label': 'Ready for Pickup!', 'emoji': '🎉'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    widget.cartProvider.clearCart();
    _animateSteps();
  }

  void _animateSteps() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _currentStep = 1);
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _currentStep = 2);
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _currentStep = 3);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              // Success animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.success.withValues(alpha: 0.2),
                          AppColors.success.withValues(alpha: 0.05),
                        ],
                      ),
                      border: Border.all(color: AppColors.success, width: 3),
                    ),
                    child: const Center(
                      child: Text('🎉', style: TextStyle(fontSize: 70)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    Text(
                      'Order Placed!',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your coffee is being prepared with love ☕',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Order details card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightBrown.withValues(alpha: 0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _orderDetailRow('Order #', 'BB-${DateTime.now().millisecondsSinceEpoch % 10000}'),
                    const Divider(color: AppColors.lightBrown, height: 24),
                    _orderDetailRow('Items', '${widget.itemCount} item(s)'),
                    const SizedBox(height: 8),
                    _orderDetailRow(
                        'Total', '\$${widget.total.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    _orderDetailRow('Est. Time', '10–15 minutes'),
                    const SizedBox(height: 8),
                    _orderDetailRow('Pickup at', 'Brew & Bliss – Main Branch'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Progress Steps
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Status',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBrown,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...List.generate(_steps.length, (index) {
                      final isDone = index <= _currentStep;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDone
                                    ? AppColors.success
                                    : AppColors.lightGrey,
                              ),
                              child: Center(
                                child: isDone
                                    ? const Icon(Icons.check,
                                        color: AppColors.white, size: 20)
                                    : Text(
                                        '${index + 1}',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${_steps[index]['emoji']} ${_steps[index]['label']}',
                              style: GoogleFonts.poppins(
                                color: isDone
                                    ? AppColors.darkBrown
                                    : AppColors.grey,
                                fontWeight: isDone
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const Spacer(),

              // Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text('Back to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _orderDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(color: AppColors.grey, fontSize: 14),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
