import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _MenuItem(label: 'My Posts', icon: Icons.post_add),
      _MenuItem(label: 'Saved', icon: Icons.bookmark),
      _MenuItem(label: 'Notifications', icon: Icons.notifications, trailing: '3'),
      _MenuItem(label: 'Account Settings', icon: Icons.settings),
      _MenuItem(label: 'Help & Support', icon: Icons.help_outline),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary), onPressed: () {}),
                  const Expanded(child: Center(child: Text('Profile', style: TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)))),
                  IconButton(icon: const Icon(Icons.settings, color: AppColors.textPrimary), onPressed: () {}),
                ],
              ),
              const SizedBox(height: 18),
              CircleAvatar(radius: 42, backgroundColor: AppColors.accent, child: const Icon(Icons.person, size: 40, color: Colors.black)),
              const SizedBox(height: 16),
              const Text('Aline Umuhoza', style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.circle, color: Colors.greenAccent, size: 12),
                  SizedBox(width: 8),
                  Text('Kigali Campus', style: TextStyle(color: AppColors.textSecondary)),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _ProfileStat(value: '23', label: 'Events'),
                    _ProfileStat(value: '5', label: 'Communities'),
                    _ProfileStat(value: '87', label: 'Connections'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => items[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? trailing;

  const _MenuItem({required this.label, required this.icon, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: Colors.black),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600))),
          if (trailing != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
              child: Text(trailing!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary, size: 16),
        ],
      ),
    );
  }
}
