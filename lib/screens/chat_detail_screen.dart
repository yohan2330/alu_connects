import 'package:flutter/material.dart';
import '../theme.dart';

class ChatDetailScreen extends StatelessWidget {
  static const routeName = '/chat-detail';

  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('AI Workshop Group'),
            SizedBox(height: 2),
            Text(
              '32 members',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: const [
                _ChatBubble(
                  text:
                      'Has everyone uploaded their model architecture for the Kigali summit prep?',
                  isSent: false,
                  time: '09:41 AM',
                ),
                _ChatBubble(
                  text: 'workshop_agenda.pdf • 1.2MB',
                  isSent: false,
                  isAttachment: true,
                  time: '10:02 AM',
                ),
                _ChatBubble(
                  text:
                      'Just finished mine. Sending the Mauritius campus update in a bit!',
                  isSent: true,
                  time: '10:02 AM',
                ),
                _ChatBubble(
                  text:
                      'Great. We need to finalize the presentation by tomorrow evening.',
                  isSent: false,
                  time: '10:05 AM',
                ),
                _ChatBubble(text: 'On it! 🚀', isSent: true, time: '10:06 AM'),
              ],
            ),
          ),
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Row(
              children: [
                const Icon(
                  Icons.emoji_emotions,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
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
                const SizedBox(width: 12),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isSent;
  final bool isAttachment;
  final String time;

  const _ChatBubble({
    required this.text,
    required this.isSent,
    this.isAttachment = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
        left: isSent ? 60 : 0,
        right: isSent ? 0 : 60,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSent ? AppColors.accent : AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(isSent ? 18 : 4),
          bottomRight: Radius.circular(isSent ? 4 : 18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAttachment)
            Row(
              children: const [
                Icon(Icons.insert_drive_file, color: Colors.white70),
                SizedBox(width: 8),
                Text(
                  'workshop_agenda.pdf',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (isAttachment) const SizedBox(height: 10),
          Text(text, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
