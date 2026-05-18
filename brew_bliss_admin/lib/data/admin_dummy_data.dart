// lib/data/admin_dummy_data.dart

import '../models/admin_models.dart';

class AdminDummyData {
  // ── Menu Items ──────────────────────────────────────────────
  static List<MenuItem> menuItems = [
    MenuItem(id: '1', name: 'Classic Espresso',    category: 'Hot',    price: 3.50, emoji: '☕', stock: true,  rating: 4.8, orders: 312),
    MenuItem(id: '2', name: 'Caramel Latte',       category: 'Hot',    price: 5.00, emoji: '🍮', stock: true,  rating: 4.9, orders: 528),
    MenuItem(id: '3', name: 'Hazelnut Cappuccino', category: 'Hot',    price: 4.75, emoji: '🫗', stock: true,  rating: 4.7, orders: 241),
    MenuItem(id: '4', name: 'Vanilla Flat White',  category: 'Hot',    price: 4.50, emoji: '🤍', stock: false, rating: 4.6, orders: 198),
    MenuItem(id: '5', name: 'Cold Brew',           category: 'Cold',   price: 5.50, emoji: '🧊', stock: true,  rating: 4.9, orders: 445),
    MenuItem(id: '6', name: 'Iced Caramel Macchiato', category: 'Cold', price: 5.75, emoji: '🧋', stock: true, rating: 4.8, orders: 389),
    MenuItem(id: '7', name: 'Frappuccino Mocha',   category: 'Cold',   price: 6.25, emoji: '🥤', stock: true,  rating: 4.7, orders: 276),
    MenuItem(id: '8', name: 'Iced Matcha Latte',   category: 'Cold',   price: 5.25, emoji: '🍵', stock: false, rating: 4.6, orders: 167),
    MenuItem(id: '9', name: 'Butter Croissant',    category: 'Snacks', price: 3.25, emoji: '🥐', stock: true,  rating: 4.5, orders: 203),
    MenuItem(id: '10', name: 'Blueberry Muffin',   category: 'Snacks', price: 3.50, emoji: '🫐', stock: true,  rating: 4.6, orders: 188),
    MenuItem(id: '11', name: 'Avocado Toast',       category: 'Snacks', price: 7.50, emoji: '🥑', stock: true,  rating: 4.7, orders: 142),
    MenuItem(id: '12', name: 'Chocolate Brownie',   category: 'Snacks', price: 4.00, emoji: '🍫', stock: true,  rating: 4.9, orders: 334),
  ];

  // ── Customers ───────────────────────────────────────────────
  static List<Customer> customers = [
    Customer(id: 'C001', name: 'Sarah Khan',     email: 'sarah.k@email.com',  phone: '+92 300 1111111', orders: 14, totalSpent: 87.50,  joined: 'Jan 12, 2026', status: 'Active'),
    Customer(id: 'C002', name: 'Ahmed Raza',     email: 'ahmed.r@email.com',  phone: '+92 301 2222222', orders: 9,  totalSpent: 52.25,  joined: 'Feb 03, 2026', status: 'Active'),
    Customer(id: 'C003', name: 'Maria Lopez',    email: 'maria.l@email.com',  phone: '+92 302 3333333', orders: 21, totalSpent: 134.75, joined: 'Dec 20, 2025', status: 'Active'),
    Customer(id: 'C004', name: 'Usman Ali',      email: 'usman.a@email.com',  phone: '+92 303 4444444', orders: 5,  totalSpent: 28.00,  joined: 'Mar 15, 2026', status: 'Inactive'),
    Customer(id: 'C005', name: 'Fatima Malik',   email: 'fatima.m@email.com', phone: '+92 304 5555555', orders: 18, totalSpent: 112.00, joined: 'Nov 08, 2025', status: 'Active'),
    Customer(id: 'C006', name: 'John Smith',     email: 'john.s@email.com',   phone: '+92 305 6666666', orders: 3,  totalSpent: 17.25,  joined: 'Apr 01, 2026', status: 'Active'),
    Customer(id: 'C007', name: 'Aisha Tariq',    email: 'aisha.t@email.com',  phone: '+92 306 7777777', orders: 32, totalSpent: 198.50, joined: 'Oct 10, 2025', status: 'VIP'),
    Customer(id: 'C008', name: 'Bilal Hassan',   email: 'bilal.h@email.com',  phone: '+92 307 8888888', orders: 7,  totalSpent: 43.75,  joined: 'Mar 28, 2026', status: 'Active'),
  ];

  // ── Orders ──────────────────────────────────────────────────
  static List<OrderModel> orders = [
    OrderModel(id: 'BB-9021', customer: 'Sarah Khan',   items: 'Caramel Latte × 2',          total: 10.00, time: '09:15 AM', status: 'Completed', payMethod: 'Card'),
    OrderModel(id: 'BB-9020', customer: 'Ahmed Raza',   items: 'Cold Brew + Croissant',       total: 8.75,  time: '09:22 AM', status: 'Brewing',   payMethod: 'PayPal'),
    OrderModel(id: 'BB-9019', customer: 'Maria Lopez',  items: 'Frappuccino Mocha × 3',       total: 18.75, time: '09:30 AM', status: 'Pending',   payMethod: 'Card'),
    OrderModel(id: 'BB-9018', customer: 'Usman Ali',    items: 'Classic Espresso',            total: 3.50,  time: '09:45 AM', status: 'Ready',     payMethod: 'Cash'),
    OrderModel(id: 'BB-9017', customer: 'Fatima Malik', items: 'Iced Matcha Latte + Brownie', total: 9.25,  time: '10:00 AM', status: 'Completed', payMethod: 'Card'),
    OrderModel(id: 'BB-9016', customer: 'John Smith',   items: 'Hazelnut Cappuccino × 2',     total: 9.50,  time: '10:12 AM', status: 'Brewing',   payMethod: 'Card'),
    OrderModel(id: 'BB-9015', customer: 'Aisha Tariq',  items: 'Cold Brew × 2 + Avocado Toast', total: 18.50, time: '10:20 AM', status: 'Pending', payMethod: 'PayPal'),
    OrderModel(id: 'BB-9014', customer: 'Bilal Hassan', items: 'Caramel Latte + Muffin',      total: 8.50,  time: '10:35 AM', status: 'Completed', payMethod: 'Cash'),
    OrderModel(id: 'BB-9013', customer: 'Sarah Khan',   items: 'Vanilla Flat White',          total: 4.50,  time: '10:50 AM', status: 'Cancelled', payMethod: 'Card'),
    OrderModel(id: 'BB-9012', customer: 'Ahmed Raza',   items: 'Chocolate Brownie × 2',       total: 8.00,  time: '11:05 AM', status: 'Ready',     payMethod: 'Cash'),
  ];

  // ── Notifications ────────────────────────────────────────────
  static List<AdminNotification> notifications = [
    AdminNotification(title: 'New Order Received',       body: 'BB-9021: Caramel Latte × 2 from Sarah Khan', time: '2 min ago',  isRead: false, type: 'order'),
    AdminNotification(title: 'Low Stock Alert',          body: 'Vanilla Flat White is out of stock',         time: '15 min ago', isRead: false, type: 'warning'),
    AdminNotification(title: 'New Customer Registered',  body: 'John Smith joined Brew & Bliss',             time: '1 hr ago',   isRead: true,  type: 'user'),
    AdminNotification(title: 'Order Cancelled',          body: 'BB-9013 was cancelled by Sarah Khan',        time: '2 hr ago',   isRead: true,  type: 'error'),
    AdminNotification(title: 'Daily Report Ready',       body: 'May 09 sales report is now available',       time: '3 hr ago',   isRead: true,  type: 'info'),
    AdminNotification(title: 'New Review Received',      body: 'Aisha Tariq left a 5-star review ⭐',        time: '5 hr ago',   isRead: true,  type: 'info'),
  ];

  // ── Analytics data ──────────────────────────────────────────
  static List<double> weeklySales   = [320, 450, 380, 520, 490, 610, 575];
  static List<String> weekDays      = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static List<double> categoryShare = [45, 35, 20]; // Hot, Cold, Snacks
  static List<String> categoryNames = ['Hot', 'Cold', 'Snacks'];

  static Map<String, dynamic> dashboardStats = {
    'todayRevenue'  : 487.25,
    'totalOrders'   : 10,
    'activeCustomers': 8,
    'pendingOrders' : 3,
    'weekRevenue'   : 3345.00,
    'monthRevenue'  : 12870.00,
    'avgOrderValue' : 9.35,
    'topItem'       : 'Caramel Latte',
  };
}
