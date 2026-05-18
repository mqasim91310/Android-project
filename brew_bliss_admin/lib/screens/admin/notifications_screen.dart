// lib/screens/admin/notifications_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/admin_theme.dart';
import '../../data/admin_dummy_data.dart';
import '../../models/admin_models.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<AdminNotification> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = List.from(AdminDummyData.notifications);
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'order':   return AdminColors.info;
      case 'warning': return AdminColors.warning;
      case 'user':    return AdminColors.success;
      case 'error':   return AdminColors.error;
      default:        return AdminColors.mediumBrown;
    }
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'order':   return Icons.receipt_long;
      case 'warning': return Icons.warning_amber;
      case 'user':    return Icons.person_add;
      case 'error':   return Icons.cancel;
      default:        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final unread = _notifications.where((n) => !n.isRead).length;

    return Column(
      children: [
        // Header bar
        Container(
          color: AdminColors.white,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$unread unread notifications',
                  style: GoogleFonts.poppins(
                      color: AdminColors.grey, fontSize: 13)),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    for (final n in _notifications) {
                      n.isRead = true;
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('All marked as read ✅',
                        style: GoogleFonts.poppins()),
                    backgroundColor: AdminColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
                },
                icon: const Icon(Icons.done_all,
                    color: AdminColors.darkBrown, size: 18),
                label: Text('Mark all read',
                    style: GoogleFonts.poppins(
                        color: AdminColors.darkBrown,
                        fontWeight: FontWeight.w600,
                        fontSize: 13)),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              final n = _notifications[i];
              final color = _typeColor(n.type);
              return Dismissible(
                key: Key('notif-$i'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: AdminColors.error,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: AdminColors.white),
                ),
                onDismissed: (_) {
                  setState(() => _notifications.removeAt(i));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Notification dismissed',
                        style: GoogleFonts.poppins()),
                    backgroundColor: AdminColors.grey,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
                },
                child: GestureDetector(
                  onTap: () {
                    setState(() => n.isRead = true);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: n.isRead
                          ? AdminColors.white
                          : color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: n.isRead
                              ? AdminColors.lightBrown.withOpacity(0.3)
                              : color.withOpacity(0.3)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(_typeIcon(n.type), color: color, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(n.title,
                                        style: GoogleFonts.poppins(
                                          fontWeight: n.isRead
                                              ? FontWeight.w500
                                              : FontWeight.bold,
                                          color: AdminColors.darkBrown,
                                          fontSize: 14,
                                        )),
                                  ),
                                  if (!n.isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(n.body,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AdminColors.grey,
                                      height: 1.4)),
                              const SizedBox(height: 6),
                              Text(n.time,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AdminColors.lightBrown)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
