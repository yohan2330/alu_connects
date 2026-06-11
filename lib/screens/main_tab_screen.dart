import 'package:flutter/material.dart';
import '../services/auth_service.dart';
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
  bool _canPost = false;
  bool _hasLoadedPermission = false;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    final canPost = await AuthService.canPost();
    if (!mounted) return;
    setState(() {
      _canPost = canPost;
      _hasLoadedPermission = true;
    });
  }

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
      floatingActionButton: _hasLoadedPermission && _canPost
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, CreatePostScreen.routeName);
              },
              backgroundColor: AppColors.accent,
              child: const Icon(Icons.add, color: Colors.black),
            )
          : null,
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
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : Colors.transparent,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 24,
          color: selected ? Colors.black : AppColors.textSecondary,
        ),
      ),
    );
  }
}
