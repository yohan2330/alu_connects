import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';

class ChatDetailScreen extends StatefulWidget {
  static const routeName = '/chat-detail';

  final String? chatId;
  final String? title;
  final bool? isGroup;
  final int? memberCount;

  const ChatDetailScreen({
    super.key,
    this.chatId,
    this.title,
    this.isGroup,
    this.memberCount,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final List<_Message> _messages = [];
  bool _isLoading = true;

  // Fallback values when opened via named route (no arguments)
  String get _chatId => widget.chatId ?? 'default-chat';
  String get _title => widget.title ?? 'AI Workshop Group';
  bool get _isGroup => widget.isGroup ?? true;
  int get _memberCount => widget.memberCount ?? 32;

  String get _storageKey => 'chat_messages_$_chatId';

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_storageKey);

    if (stored != null) {
      try {
        final List<dynamic> decoded = jsonDecode(stored);
        setState(() {
          _messages.addAll(
            decoded.map((m) => _Message.fromJson(m)).toList(),
          );
          _isLoading = false;
        });
      } catch (e) {
        _loadDefaultMessages();
      }
    } else {
      _loadDefaultMessages();
    }
  }

  void _loadDefaultMessages() {
    final defaults = [
      _Message(
        id: '1',
        text: 'Has everyone uploaded their model architecture for the Kigali summit prep?',
        isSent: false,
        senderName: 'Fatima',
        time: '09:41 AM',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      _Message(
        id: '2',
        text: 'workshop_agenda.pdf',
        isSent: false,
        senderName: 'David',
        isAttachment: true,
        attachmentSize: '1.2MB',
        time: '10:02 AM',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
      ),
      _Message(
        id: '3',
        text: 'Just finished mine. Sending the Mauritius campus update in a bit!',
        isSent: true,
        senderName: 'Me',
        time: '10:02 AM',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      _Message(
        id: '4',
        text: 'Great. We need to finalize the presentation by tomorrow evening.',
        isSent: false,
        senderName: 'Jean',
        time: '10:05 AM',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      _Message(
        id: '5',
        text: 'On it! 🚀',
        isSent: true,
        senderName: 'Me',
        time: '10:06 AM',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];

    setState(() {
      _messages.addAll(defaults);
      _isLoading = false;
    });
    _saveMessages();
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_messages.map((m) => m.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    setState(() {
      _messages.add(
        _Message(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          isSent: true,
          senderName: 'Me',
          time: timeString,
          timestamp: now,
        ),
      );
    });

    _messageController.clear();
    _saveMessages();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.accent,
              child: Text(
                _title[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (_isGroup)
                    Text(
                      '$_memberCount members',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () {
              _showChatOptions(context);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.accent),
            )
          : Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: _messages.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            itemCount: _messages.length,
                            itemBuilder: (context, index) {
                              final message = _messages[index];
                              return _ChatBubble(
                                message: message,
                                isGroup: _isGroup,
                              );
                            },
                          ),
                  ),
                ),
                Container(
                  color: AppColors.surface,
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            focusNode: _focusNode,
                            style: const TextStyle(color: AppColors.textPrimary),
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              hintStyle: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              filled: true,
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.send,
                              color: Colors.black,
                            ),
                            onPressed: _sendMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
            'No messages yet',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Be the first to send a message!',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _showChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person_add, color: AppColors.accent),
                title: const Text(
                  'Add Members',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.notifications_off, color: AppColors.accent),
                title: const Text(
                  'Mute Notifications',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
                title: const Text(
                  'Leave Group',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message {
  final String id;
  final String text;
  final bool isSent;
  final String senderName;
  final bool isAttachment;
  final String? attachmentSize;
  final String time;
  final DateTime timestamp;

  _Message({
    required this.id,
    required this.text,
    required this.isSent,
    required this.senderName,
    this.isAttachment = false,
    this.attachmentSize,
    required this.time,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'isSent': isSent,
        'senderName': senderName,
        'isAttachment': isAttachment,
        'attachmentSize': attachmentSize,
        'time': time,
        'timestamp': timestamp.toIso8601String(),
      };

  factory _Message.fromJson(Map<String, dynamic> json) => _Message(
        id: json['id'],
        text: json['text'],
        isSent: json['isSent'],
        senderName: json['senderName'],
        isAttachment: json['isAttachment'] ?? false,
        attachmentSize: json['attachmentSize'],
        time: json['time'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

class _ChatBubble extends StatelessWidget {
  final _Message message;
  final bool isGroup;

  const _ChatBubble({
    required this.message,
    required this.isGroup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: message.isSent ? 60 : 0,
        right: message.isSent ? 0 : 60,
      ),
      child: Column(
        crossAxisAlignment:
            message.isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isGroup && !message.isSent)
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 4),
              child: Text(
                message.senderName,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: message.isSent ? AppColors.accent : AppColors.surface,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(message.isSent ? 18 : 4),
                bottomRight: Radius.circular(message.isSent ? 4 : 18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.isAttachment)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message.isSent
                          ? AppColors.accentDark
                          : AppColors.panel,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.insert_drive_file,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (message.attachmentSize != null)
                              Text(
                                message.attachmentSize!,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (!message.isAttachment)
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isSent ? Colors.black : Colors.white,
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        color: message.isSent
                            ? Colors.black54
                            : AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                    if (message.isSent) ...[
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.done_all,
                        size: 14,
                        color: Colors.black54,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}