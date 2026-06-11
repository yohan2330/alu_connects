import 'package:flutter/material.dart';
import '../theme.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  static const routeName = '/chats';

  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock data — in a real app this would come from a provider/service
  final List<_ChatItem> _allChats = [
    _ChatItem(
      id: '1',
      title: 'Entrepreneurship Club',
      subtitle: 'Can someone confirm the pitch deck submit?',
      time: '10:30 AM',
      unread: 3,
      isGroup: true,
      memberCount: 156,
    ),
    _ChatItem(
      id: '2',
      title: 'AI Workshop Group',
      subtitle: 'The new transformer architecture is insane',
      time: '9:45 AM',
      unread: 2,
      isGroup: true,
      memberCount: 32,
    ),
    _ChatItem(
      id: '3',
      title: 'Campus Leaders',
      subtitle: 'Meeting adjourned. Thanks everyone for attending!',
      time: 'Yesterday',
      unread: 0,
      isGroup: true,
      memberCount: 24,
    ),
    _ChatItem(
      id: '4',
      title: 'Travel Buddies',
      subtitle: 'Mauritius trip planning starts now ✈️',
      time: 'Yesterday',
      unread: 0,
      isGroup: true,
      memberCount: 18,
    ),
    _ChatItem(
      id: '5',
      title: 'ALU Debate Society',
      subtitle: 'I strongly disagree with the motion.',
      time: '2h ago',
      unread: 0,
      isGroup: true,
      memberCount: 89,
    ),
  ];

  List<_ChatItem> get _filteredChats {
    if (_searchQuery.trim().isEmpty) return _allChats;
    return _allChats
        .where((chat) =>
            chat.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            chat.subtitle.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredChats;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Chats',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar — NOW ACTUALLY WORKS
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.textSecondary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        style: const TextStyle(color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          hintText: 'Search chats...',
                          hintStyle: TextStyle(color: AppColors.textSecondary),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                        child: const Icon(
                          Icons.close,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Chat List
              Expanded(
                child: filtered.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final chat = filtered[index];
                          return _buildChatTile(chat);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: AppColors.textMuted.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No chats found',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty
                ? 'Start a conversation from an event!'
                : 'Try a different search term',
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(_ChatItem chat) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailScreen(
                chatId: chat.id,
                title: chat.title,
                isGroup: chat.isGroup,
                memberCount: chat.memberCount,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              // Avatar with online indicator for groups
              Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: AppColors.accent,
                    child: Text(
                      chat.title[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if (chat.isGroup)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 14),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          chat.time,
                          style: TextStyle(
                            color: chat.unread > 0
                                ? AppColors.accent
                                : AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            chat.subtitle,
                            style: TextStyle(
                              color: chat.unread > 0
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontSize: 14,
                              fontWeight: chat.unread > 0
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        if (chat.unread > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${chat.unread}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
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
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final int unread;
  final bool isGroup;
  final int memberCount;

  _ChatItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.unread,
    this.isGroup = false,
    this.memberCount = 0,
  });
}