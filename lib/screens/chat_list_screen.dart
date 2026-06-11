import 'package:flutter/material.dart';
import '../theme.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    final chats = [
      _ChatItem(title: 'Entrepreneurship Club',  subtitle: 'Can someone confirm the pitch deck submit?',    time: '10:30 AM', unread: 3),
      _ChatItem(title: 'AI Workshop Group',       subtitle: 'The new transformer architecture is insane',    time: '9:45 AM',  unread: 2),
      _ChatItem(title: 'Campus Leaders',          subtitle: 'Meeting adjourned. Thanks everyone for atten', time: 'Yesterday', unread: 0),
      _ChatItem(title: 'Travel Buddies',          subtitle: 'Mauritius trip planning starts now ✈️',         time: 'Yesterday', unread: 0),
      _ChatItem(title: 'ALU Debate Society',      subtitle: 'I strongly disagree with the motion.',          time: '2h ago',    unread: 0),
    ];

    return Scaffold(
      backgroundColor: col.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chats',
                  style: TextStyle(color: col.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(18)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    Icon(Icons.search, color: col.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(child: Text('Search chats...',
                        style: TextStyle(color: col.textSecondary))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount:        chats.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ListTile(
                      onTap:           () => Navigator.pushNamed(context, ChatDetailScreen.routeName),
                      shape:           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      tileColor:       col.surface,
                      contentPadding:  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      leading: CircleAvatar(
                        backgroundColor: col.accent,
                        child: Text(chat.title[0],
                            style: const TextStyle(color: Colors.black)),
                      ),
                      title: Text(chat.title,
                          style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.bold)),
                      subtitle: Text(chat.subtitle,
                          style: TextStyle(color: col.textSecondary, overflow: TextOverflow.ellipsis)),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: [
                          Text(chat.time,
                              style: TextStyle(color: col.textSecondary, fontSize: 12)),
                          if (chat.unread > 0) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(12)),
                              child: Text('${chat.unread}',
                                  style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatItem {
  final String title;
  final String subtitle;
  final String time;
  final int    unread;
  _ChatItem({required this.title, required this.subtitle, required this.time, required this.unread});
}
