import 'package:flutter/material.dart';
import '../theme.dart';

// Shared notifier so HomeScreen badge updates when notifications are read here.
final unreadNotificationsNotifier = ValueNotifier<int>(4);

enum _NType { event, opportunity, community, deadline, follow, like }

class _Notif {
  final _NType type;
  final String title;
  final String body;
  final String time;
  bool   read;

  _Notif({
    required this.type,
    required this.title,
    required this.body,
    required this.time,
    this.read = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _today = [
    _Notif(
      type:  _NType.deadline,
      title: 'Deadline in 24 hours',
      body:  'Pan-African AI Challenge closes tomorrow — Jun 12, 2026.',
      time:  '1h ago',
    ),
    _Notif(
      type:  _NType.event,
      title: 'Debate Night is tomorrow',
      body:  'ALU Debate Society · Room 204, ALU Campus at 6 PM.',
      time:  '3h ago',
    ),
    _Notif(
      type:  _NType.follow,
      title: 'Chisom O. started following you',
      body:  'Software Engineer · ALU Mauritius Campus.',
      time:  '5h ago',
    ),
    _Notif(
      type:  _NType.opportunity,
      title: 'New opportunity posted',
      body:  'Google Africa Developer Scholarship — Remote, stipend included.',
      time:  '7h ago',
    ),
  ];

  final _earlier = [
    _Notif(
      type:  _NType.like,
      title: 'Entrepreneurship Club liked your comment',
      body:  'On "Recap: Pitch Night was a massive success!"',
      time:  'Yesterday',
      read:  true,
    ),
    _Notif(
      type:  _NType.community,
      title: 'Tech Hub posted an update',
      body:  'New workshop on Flutter & Firebase — register before spots fill.',
      time:  'Yesterday',
      read:  true,
    ),
    _Notif(
      type:  _NType.event,
      title: 'You RSVPd to Design Jam',
      body:  'Creative Studio · Block B on Jun 20, 2026.',
      time:  '2 days ago',
      read:  true,
    ),
    _Notif(
      type:  _NType.opportunity,
      title: 'Social Impact Grant deadline approaching',
      body:  'ALU Foundation · Jun 30, 2026 — prize up to \$10,000.',
      time:  '3 days ago',
      read:  true,
    ),
    _Notif(
      type:  _NType.follow,
      title: 'Fatima R. started following you',
      body:  'Entrepreneur · ALU Kigali Campus.',
      time:  '4 days ago',
      read:  true,
    ),
  ];

  int get _unreadCount => [..._today, ..._earlier].where((n) => !n.read).length;

  void _markAllRead() {
    setState(() {
      for (final n in [..._today, ..._earlier]) {
        n.read = true;
      }
    });
    unreadNotificationsNotifier.value = 0;
  }

  void _markRead(_Notif n) {
    if (n.read) return;
    setState(() => n.read = true);
    unreadNotificationsNotifier.value = _unreadCount;
  }

  (IconData, Color) _iconFor(_NType type) => switch (type) {
    _NType.event       => (Icons.event_rounded,              const Color(0xFF5C6BC0)),
    _NType.opportunity => (Icons.emoji_events_rounded,       const Color(0xFF26A69A)),
    _NType.community   => (Icons.groups_rounded,             const Color(0xFFF9A825)),
    _NType.deadline    => (Icons.warning_amber_rounded,      Colors.redAccent),
    _NType.follow      => (Icons.person_add_rounded,         const Color(0xFF42A5F5)),
    _NType.like        => (Icons.favorite_rounded,           const Color(0xFFEC407A)),
  };

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      appBar: AppBar(
        backgroundColor: col.surface,
        elevation:       0,
        leading: IconButton(
          icon:      Icon(Icons.arrow_back, color: col.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications',
            style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.bold)),
        actions: [
          if (_unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text('Mark all read',
                  style: TextStyle(color: col.accent, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildSection(context, col, 'Today',    _today),
          _buildSection(context, col, 'Earlier',  _earlier),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, AppColors col, String label, List<_Notif> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(label,
              style: TextStyle(color: col.textMuted, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8)),
        ),
        ...items.map((n) => _buildTile(context, col, n)),
      ],
    );
  }

  Widget _buildTile(BuildContext context, AppColors col, _Notif n) {
    final (icon, color) = _iconFor(n.type);
    return GestureDetector(
      onTap: () => _markRead(n),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        color: n.read ? Colors.transparent : col.accent.withValues(alpha: 0.06),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color:        color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(n.title,
                            style: TextStyle(
                              color:      col.textPrimary,
                              fontWeight: n.read ? FontWeight.w500 : FontWeight.w700,
                              fontSize:   14,
                            )),
                      ),
                      const SizedBox(width: 8),
                      if (!n.read)
                        Container(
                          width: 8, height: 8,
                          decoration: BoxDecoration(color: col.accent, shape: BoxShape.circle),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(n.body,
                      style: TextStyle(color: col.textSecondary, fontSize: 13, height: 1.4)),
                  const SizedBox(height: 6),
                  Text(n.time,
                      style: TextStyle(color: col.textMuted, fontSize: 11, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
