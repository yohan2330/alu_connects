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

  static const List<Widget> _pages = [
    HomeScreen(),
    ExploreScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  static const _tabs = [
    _Tab('Home',    Icons.home_rounded,         Icons.home_outlined),
    _Tab('Explore', Icons.explore_rounded,       Icons.explore_outlined),
    _Tab('Chat',    Icons.chat_bubble_rounded,   Icons.chat_bubble_outline_rounded),
    _Tab('Profile', Icons.person_rounded,        Icons.person_outline_rounded),
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

  @override
  Widget build(BuildContext context) {
    final col       = AppColors.of(context);
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final showPost  = _hasLoadedPermission && _canPost;

    return Scaffold(
      extendBody:      true,
      backgroundColor: col.background,
      body:            _pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPad + 18),
        child: Container(
          height: 66,
          decoration: BoxDecoration(
            color:         col.surface,
            borderRadius:  BorderRadius.circular(28),
            border:        Border.all(color: col.border, width: 0.5),
            boxShadow: [
              BoxShadow(
                color:      Colors.black.withValues(alpha: 0.45),
                blurRadius: 28,
                offset:     const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(col, 0, _tabs[0]),
              _buildNavItem(col, 1, _tabs[1]),
              if (showPost)
                _PostButton(col: col, onTap: () => Navigator.pushNamed(context, CreatePostScreen.routeName))
              else
                const SizedBox(width: 52),
              _buildNavItem(col, 2, _tabs[2]),
              _buildNavItem(col, 3, _tabs[3]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(AppColors col, int index, _Tab tab) {
    final selected = _selectedIndex == index;
    return GestureDetector(
      onTap:     () => setState(() => _selectedIndex = index),
      behavior:  HitTestBehavior.opaque,
      child: SizedBox(
        width:  60,
        height: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? tab.activeIcon : tab.inactiveIcon,
              size:  24,
              color: selected ? col.accent : col.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: TextStyle(
                color:      selected ? col.accent : col.textSecondary,
                fontSize:   10,
                fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration:    const Duration(milliseconds: 250),
              width:       selected ? 18 : 0,
              height:      3,
              decoration:  BoxDecoration(
                color:        col.accent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab {
  final String   label;
  final IconData activeIcon;
  final IconData inactiveIcon;
  const _Tab(this.label, this.activeIcon, this.inactiveIcon);
}

class _PostButton extends StatelessWidget {
  final AppColors col;
  final VoidCallback onTap;
  const _PostButton({required this.col, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:  48,
        height: 48,
        decoration: BoxDecoration(
          color:        col.accent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:      col.accent.withValues(alpha: 0.45),
              blurRadius: 14,
              offset:     const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, color: Colors.black, size: 28),
      ),
    );
  }
}
