// lib/models/coffee_item.dart

class CoffeeItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String emoji;
  final double rating;
  final int calories;
  final List<String> sizes;
  final List<String> milkOptions;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.emoji,
    required this.rating,
    required this.calories,
    required this.sizes,
    required this.milkOptions,
  });
}

class CartItem {
  final CoffeeItem item;
  int quantity;
  String selectedSize;
  String selectedMilk;

  CartItem({
    required this.item,
    this.quantity = 1,
    this.selectedSize = 'Medium',
    this.selectedMilk = 'Whole',
  });

  double get totalPrice => item.price * quantity;
}
