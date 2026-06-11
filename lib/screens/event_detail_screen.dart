import 'package:flutter/material.dart';
import '../theme.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/event-detail';
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      appBar: AppBar(
        backgroundColor: col.surface,
        elevation: 0,
        leading:  IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions:  [IconButton(icon: const Icon(Icons.share), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1527689368864-3a821dbccc34?auto=format&fit=crop&w=900&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: [
                      _TagChip(label: 'Workshop', color: Colors.blueAccent),
                      _TagChip(label: 'Tech',     color: col.accent),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text('AI for Social Impact Workshop',
                      style: TextStyle(color: col.textPrimary, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: col.textSecondary, size: 18),
                      const SizedBox(width: 8),
                      Text('09:00 AM - 01:00 PM • Tomorrow, Sept 24',
                          style: TextStyle(color: col.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.place, color: col.textSecondary, size: 18),
                      const SizedBox(width: 8),
                      Text('Innovation Lab • Mauritius Campus, Wing B',
                          style: TextStyle(color: col.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: col.accent,
                        child: const Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      Text('+45',
                          style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Text('48 doing • 12 interested',
                          style: TextStyle(color: col.textSecondary)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('About the event',
                      style: TextStyle(color: col.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Text(
                    'Join a hands-on workshop exploring how AI can drive social impact across campus initiatives. Collaborate with peers from multiple ALU campuses and build ideas that matter.',
                    style: TextStyle(color: col.textSecondary, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('RSVP Now', style: TextStyle(color: Colors.black))),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side:    BorderSide(color: col.accent),
                    shape:   RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Interested',
                        style: TextStyle(color: col.textPrimary))),
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

class _TagChip extends StatelessWidget {
  final String label;
  final Color  color;
  const _TagChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
      child: Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    );
  }
}
