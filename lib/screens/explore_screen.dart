import 'package:flutter/material.dart';
import '../theme.dart';
import 'event_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _selectedTab = 'All';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Explore', style: TextStyle(color: AppColors.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: const Icon(Icons.notifications, color: AppColors.textPrimary),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: AppColors.textSecondary),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text('Search opportunities...', style: TextStyle(color: AppColors.textSecondary)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _buildCategoryChip('All'),
                  const SizedBox(width: 10),
                  _buildCategoryChip('Events'),
                  const SizedBox(width: 10),
                  _buildCategoryChip('Opportunities'),
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionHeader('Recommended for you'),
              const SizedBox(height: 14),
              _buildFeaturedCard(context),
              const SizedBox(height: 24),
              _buildSectionHeader('Latest Updates'),
              const SizedBox(height: 14),
              Expanded(child: _buildLatestUpdates()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    final selected = _selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label, style: TextStyle(color: selected ? Colors.black : AppColors.textSecondary)),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        Text('See all', style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildFeaturedCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetailScreen.routeName);
      },
      child: Container(
        height: 210,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=900&q=80'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color.fromRGBO(0, 0, 0, 0.55), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildTag('HOT', AppColors.accent),
                  const SizedBox(width: 8),
                  _buildTag('Workshop', Colors.blueAccent),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Innovation Summit ’24', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Kigali • Tomorrow', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text('View details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildLatestUpdates() {
    final items = [
      _UpdateItem(title: 'Google Africa Internship', subtitle: 'Mauritius • Application Open', label: 'Opportunity', color: Colors.blueAccent),
      _UpdateItem(title: 'ALU Cultural Night', subtitle: 'Kigali • Main Hall', label: 'Event', color: Colors.greenAccent),
      _UpdateItem(title: 'Robotics Club Meeting', subtitle: 'Campus Lab • 7:00 PM', label: 'Club Update', color: Colors.orangeAccent),
    ];

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 14),
      itemBuilder: (context, index) => items[index],
    );
  }
}

class _UpdateItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String label;
  final Color color;

  const _UpdateItem({required this.title, required this.subtitle, required this.label, required this.color});

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
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.event, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
        ],
      ),
    );
  }
}
