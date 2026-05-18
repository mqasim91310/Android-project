// lib/providers/cart_provider.dart

import 'package:flutter/material.dart';
import '../models/coffee_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  int _stampCount = 3; // User already has 3 stamps

  List<CartItem> get items => _items;
  int get stampCount => _stampCount;

  double get subtotal => _items.fold(0, (sum, item) => sum + item.totalPrice);
  double get tax => subtotal * 0.08;
  double get total => subtotal + tax;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(CoffeeItem coffee, {String size = 'Medium', String milk = 'Whole'}) {
    final existingIndex = _items.indexWhere(
      (i) => i.item.id == coffee.id && i.selectedSize == size && i.selectedMilk == milk,
    );
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(item: coffee, selectedSize: size, selectedMilk: milk));
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _stampCount = (_stampCount + 1) % 6;
    notifyListeners();
  }
}
