// lib/models/admin_models.dart

class MenuItem {
  final String id;
  String name;
  String category;
  double price;
  String emoji;
  bool stock;
  double rating;
  int orders;

  MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.emoji,
    required this.stock,
    required this.rating,
    required this.orders,
  });
}

class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int orders;
  final double totalSpent;
  final String joined;
  String status;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orders,
    required this.totalSpent,
    required this.joined,
    required this.status,
  });
}

class OrderModel {
  final String id;
  final String customer;
  final String items;
  final double total;
  final String time;
  String status;
  final String payMethod;

  OrderModel({
    required this.id,
    required this.customer,
    required this.items,
    required this.total,
    required this.time,
    required this.status,
    required this.payMethod,
  });
}

class AdminNotification {
  final String title;
  final String body;
  final String time;
  bool isRead;
  final String type; // order, warning, user, error, info

  AdminNotification({
    required this.title,
    required this.body,
    required this.time,
    required this.isRead,
    required this.type,
  });
}
