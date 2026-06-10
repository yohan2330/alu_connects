import 'package:flutter/material.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hi, Aline! 👋', style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('What’s happening today?', style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.accent,
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text('Communities', style: TextStyle(color: AppColors.textPrimary, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildSegmentedControl(),
              const SizedBox(height: 20),
              Expanded(child: _buildCommunityList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(child: _buildSegmentButton('All Clubs', true)),
          Expanded(child: _buildSegmentButton('My Clubs', false)),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: selected ? AppColors.accent : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(label, style: TextStyle(color: selected ? Colors.black : AppColors.textSecondary, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildCommunityList() {
    final items = [
      _CommunityCard(name: 'ALU Debate Society', subtitle: '124 members', joined: false),
      _CommunityCard(name: 'Entrepreneurship Club', subtitle: '250 members', joined: true),
      _CommunityCard(name: 'Women in Leadership', subtitle: '180 members', joined: false),
      _CommunityCard(name: 'Tech & Innovation Hub', subtitle: '210 members', joined: false),
      const SizedBox(height: 16),
      _FeaturedCommunityCard(),
    ];

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) => items[index],
    );
  }
}

class _CommunityCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final bool joined;

  const _CommunityCard({required this.name, required this.subtitle, required this.joined});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.group, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: joined ? AppColors.surface : AppColors.accent,
              foregroundColor: joined ? AppColors.textPrimary : Colors.black,
              elevation: 0,
            ),
            onPressed: () {},
            child: Text(joined ? 'Joined' : 'Join'),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCommunityCard extends StatelessWidget {
  const _FeaturedCommunityCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=900&q=80'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0x88081423), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('FEATURED COMMUNITY', style: TextStyle(color: Colors.white70, fontSize: 12)),
            SizedBox(height: 8),
            Text('The Creative Nexus', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Design, Art & Digital Storytelling', style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
