import 'package:flutter/material.dart';
import '../theme.dart';
import 'create_post_screen.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'chat_list_screen.dart';

class MainTabScreen extends StatefulWidget {
  static const routeName = '/main';

  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, CreatePostScreen.routeName);
        },
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.surface,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildNavButton(index: 0, icon: Icons.home),
                  _buildNavButton(index: 1, icon: Icons.explore),
                ],
              ),
              Row(
                children: [
                  _buildNavButton(index: 2, icon: Icons.message),
                  _buildNavButton(index: 3, icon: Icons.person),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({required int index, required IconData icon}) {
    final selected = _selectedIndex == index;
    return IconButton(
      onPressed: () => _onItemTapped(index),
      icon: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: selected ? Colors.black : AppColors.textSecondary,
        ),
      ),
    );
  }
}
