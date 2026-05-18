import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────

class ChatModel {
  final String name;
  final String message;
  final String time;
  final String avatarText;
  final Color avatarColor;
  final int unreadCount;

  const ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarText,
    required this.avatarColor,
    this.unreadCount = 0,
  });
}

class StatusModel {
  final String name;
  final String time;
  final String avatarText;
  final Color avatarColor;
  final bool isViewed;

  const StatusModel({
    required this.name,
    required this.time,
    required this.avatarText,
    required this.avatarColor,
    this.isViewed = false,
  });
}

class CallModel {
  final String name;
  final String time;
  final bool isIncoming;
  final bool isMissed;
  final bool isVideo;
  final String avatarText;
  final Color avatarColor;

  const CallModel({
    required this.name,
    required this.time,
    required this.isIncoming,
    required this.isMissed,
    required this.isVideo,
    required this.avatarText,
    required this.avatarColor,
  });
}

// ─────────────────────────────────────────────
// MAIN WHATSAPP CLONE APP
// ─────────────────────────────────────────────

class WhatsAppClone extends StatelessWidget {
  const WhatsAppClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primaryColor: const Color(0xFF075E54),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF075E54)),
        useMaterial3: false,
      ),
      home: const WhatsAppHome(),
    );
  }
}

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({Key? key}) : super(key: key);

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        title: const Text(
          'WhatsApp',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'new_group', child: Text('New group')),
              const PopupMenuItem(value: 'new_broadcast', child: Text('New broadcast')),
              const PopupMenuItem(value: 'settings', child: Text('Settings')),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ChatsTab(),
          StatusTab(),
          CallsTab(),
        ],
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFAB() {
    return AnimatedBuilder(
      animation: _tabController,
      builder: (context, child) {
        return FloatingActionButton(
          backgroundColor: const Color(0xFF25D366),
          onPressed: () {},
          child: Icon(
            _tabController.index == 0
                ? Icons.chat
                : _tabController.index == 1
                    ? Icons.camera_alt
                    : Icons.add_call,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// CHATS TAB
// ─────────────────────────────────────────────

class ChatsTab extends StatelessWidget {
  const ChatsTab({Key? key}) : super(key: key);

  static final List<ChatModel> _chats = [
    ChatModel(
      name: 'Ahmed Ali',
      message: 'Okay, see you tomorrow! 👋',
      time: '10:30 AM',
      avatarText: 'AA',
      avatarColor: Colors.indigo,
      unreadCount: 2,
    ),
    ChatModel(
      name: 'Flutter Dev Group',
      message: 'Usman: Anyone completed Lab 6?',
      time: '9:45 AM',
      avatarText: 'FD',
      avatarColor: Colors.teal,
      unreadCount: 5,
    ),
    ChatModel(
      name: 'Sara Khan',
      message: '📷 Photo',
      time: 'Yesterday',
      avatarText: 'SK',
      avatarColor: Colors.pink,
    ),
    ChatModel(
      name: 'Bilal Raza',
      message: 'Sure, I will send it later.',
      time: 'Yesterday',
      avatarText: 'BR',
      avatarColor: Colors.orange,
    ),
    ChatModel(
      name: 'FAST Study Group',
      message: 'Hamza: Assignment deadline today!',
      time: 'Mon',
      avatarText: 'FS',
      avatarColor: Colors.purple,
      unreadCount: 12,
    ),
    ChatModel(
      name: 'Mama',
      message: 'Beta, ghar kab aaoge?',
      time: 'Mon',
      avatarText: 'M',
      avatarColor: Colors.red,
    ),
    ChatModel(
      name: 'Hasan Tariq',
      message: '✅ Voice message',
      time: 'Sun',
      avatarText: 'HT',
      avatarColor: Colors.cyan,
    ),
    ChatModel(
      name: 'Zara Malik',
      message: 'Haha, that was so funny 😂',
      time: 'Sun',
      avatarText: 'ZM',
      avatarColor: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _chats.length,
      separatorBuilder: (_, __) => const Divider(
        height: 1,
        indent: 80,
        endIndent: 16,
      ),
      itemBuilder: (context, index) => _ChatTile(chat: _chats[index]),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ChatModel chat;
  const _ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: chat.avatarColor,
        child: Text(
          chat.avatarText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            chat.name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            chat.time,
            style: TextStyle(
              fontSize: 12,
              color: chat.unreadCount > 0
                  ? const Color(0xFF25D366)
                  : Colors.grey,
            ),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              chat.message,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ),
          if (chat.unreadCount > 0)
            Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: const BoxDecoration(
                color: Color(0xFF25D366),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${chat.unreadCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// STATUS TAB
// ─────────────────────────────────────────────

class StatusTab extends StatelessWidget {
  const StatusTab({Key? key}) : super(key: key);

  static final List<StatusModel> _statuses = [
    StatusModel(
      name: 'Ahmed Ali',
      time: '10 min ago',
      avatarText: 'AA',
      avatarColor: Colors.indigo,
    ),
    StatusModel(
      name: 'Sara Khan',
      time: '25 min ago',
      avatarText: 'SK',
      avatarColor: Colors.pink,
    ),
    StatusModel(
      name: 'Bilal Raza',
      time: '1 hour ago',
      avatarText: 'BR',
      avatarColor: Colors.orange,
      isViewed: true,
    ),
    StatusModel(
      name: 'Zara Malik',
      time: '2 hours ago',
      avatarText: 'ZM',
      avatarColor: Colors.green,
      isViewed: true,
    ),
    StatusModel(
      name: 'Hasan Tariq',
      time: '3 hours ago',
      avatarText: 'HT',
      avatarColor: Colors.cyan,
      isViewed: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // My Status
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white, size: 32),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF25D366),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          title: const Text(
            'My Status',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          subtitle: const Text(
            'Tap to add status update',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
          child: Text(
            'RECENT UPDATES',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
        ...(_statuses.where((s) => !s.isViewed).map((s) => _StatusTile(status: s))),
        if (_statuses.any((s) => s.isViewed)) ...[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 12, bottom: 4),
            child: Text(
              'VIEWED UPDATES',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...(_statuses.where((s) => s.isViewed).map((s) => _StatusTile(status: s))),
        ],
      ],
    );
  }
}

class _StatusTile extends StatelessWidget {
  final StatusModel status;
  const _StatusTile({required this.status});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: status.isViewed ? Colors.grey : const Color(0xFF25D366),
            width: 2.5,
          ),
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: status.avatarColor,
          child: Text(
            status.avatarText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(
        status.name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      subtitle: Text(
        status.time,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// CALLS TAB
// ─────────────────────────────────────────────

class CallsTab extends StatelessWidget {
  const CallsTab({Key? key}) : super(key: key);

  static final List<CallModel> _calls = [
    CallModel(
      name: 'Ahmed Ali',
      time: 'Today, 10:30 AM',
      isIncoming: true,
      isMissed: false,
      isVideo: false,
      avatarText: 'AA',
      avatarColor: Colors.indigo,
    ),
    CallModel(
      name: 'Sara Khan',
      time: 'Today, 9:15 AM',
      isIncoming: false,
      isMissed: false,
      isVideo: true,
      avatarText: 'SK',
      avatarColor: Colors.pink,
    ),
    CallModel(
      name: 'Bilal Raza',
      time: 'Yesterday, 7:00 PM',
      isIncoming: true,
      isMissed: true,
      isVideo: false,
      avatarText: 'BR',
      avatarColor: Colors.orange,
    ),
    CallModel(
      name: 'Hasan Tariq',
      time: 'Yesterday, 3:45 PM',
      isIncoming: false,
      isMissed: false,
      isVideo: false,
      avatarText: 'HT',
      avatarColor: Colors.cyan,
    ),
    CallModel(
      name: 'Zara Malik',
      time: 'Monday, 11:00 AM',
      isIncoming: true,
      isMissed: true,
      isVideo: true,
      avatarText: 'ZM',
      avatarColor: Colors.green,
    ),
    CallModel(
      name: 'Flutter Dev Group',
      time: 'Sunday, 6:00 PM',
      isIncoming: true,
      isMissed: false,
      isVideo: true,
      avatarText: 'FD',
      avatarColor: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _calls.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: 80, endIndent: 16),
      itemBuilder: (context, index) => _CallTile(call: _calls[index]),
    );
  }
}

class _CallTile extends StatelessWidget {
  final CallModel call;
  const _CallTile({required this.call});

  @override
  Widget build(BuildContext context) {
    final callColor = call.isMissed ? Colors.red : Colors.green.shade700;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: call.avatarColor,
        child: Text(
          call.avatarText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      title: Text(
        call.name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: call.isMissed ? Colors.red : Colors.black,
        ),
      ),
      subtitle: Row(
        children: [
          Icon(
            call.isIncoming ? Icons.call_received : Icons.call_made,
            size: 14,
            color: callColor,
          ),
          const SizedBox(width: 4),
          Text(
            call.time,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
          ),
        ],
      ),
      trailing: Icon(
        call.isVideo ? Icons.videocam_outlined : Icons.call_outlined,
        color: const Color(0xFF075E54),
        size: 24,
      ),
    );
  }
}