import 'package:flutter/material.dart';
import '../theme.dart';

class CommunitiesScreen extends StatefulWidget {
  static const routeName = '/communities';
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  String _selectedTab = 'All Clubs';

  static const _allClubs = [
    _Club(name: 'ALU Debate Society',      members: 124, joined: false, color: Color(0xFF5C6BC0)),
    _Club(name: 'Entrepreneurship Club',   members: 250, joined: true,  color: Color(0xFFF9A825)),
    _Club(name: 'Women in Leadership',     members: 180, joined: false, color: Color(0xFFEC407A)),
    _Club(name: 'Tech & Innovation Hub',   members: 210, joined: false, color: Color(0xFF26A69A)),
    _Club(name: 'Robotics Club',           members: 98,  joined: false, color: Color(0xFF7E57C2)),
    _Club(name: 'Creative Nexus',          members: 143, joined: true,  color: Color(0xFFEF5350)),
    _Club(name: 'Pan-African Society',     members: 312, joined: false, color: Color(0xFF66BB6A)),
  ];

  List<_Club> get _visibleClubs => _selectedTab == 'My Clubs'
      ? _allClubs.where((club) => club.joined).toList()
      : _allClubs;

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, col),
            _buildSegmentedControl(col),
            const SizedBox(height: 20),
            Expanded(child: _buildContent(col)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppColors col) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 20),
      child: Row(
        children: [
          IconButton(
            icon:      Icon(Icons.arrow_back_ios_new, color: col.textPrimary, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          Text(
            'Communities',
            style: TextStyle(color: col.textPrimary, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl(AppColors col) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Expanded(child: _buildSegmentButton('All Clubs', col)),
            Expanded(child: _buildSegmentButton('My Clubs',  col)),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String label, AppColors col) {
    final selected = _selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:  const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color:        selected ? col.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color:      selected ? Colors.black : col.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(AppColors col) {
    final clubs = _visibleClubs;
    return ListView.builder(
      padding:   const EdgeInsets.fromLTRB(20, 0, 20, 100),
      itemCount: clubs.length + 1,
      itemBuilder: (context, index) {
        if (index == clubs.length) return _buildFeaturedCard(col);
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child:   _CommunityCard(col: col, club: clubs[index]),
        );
      },
    );
  }

  Widget _buildFeaturedCard(AppColors col) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          image: const DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=900&q=80'),
            fit:   BoxFit.cover,
            colorFilter: ColorFilter.mode(Color(0x99081423), BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(8)),
                child: const Text('FEATURED', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              const Text('The Creative Nexus',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              const Text('Design, Art & Digital Storytelling',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Club {
  final String name;
  final int    members;
  final bool   joined;
  final Color  color;
  const _Club({required this.name, required this.members, required this.joined, required this.color});
}

class _CommunityCard extends StatefulWidget {
  final AppColors col;
  final _Club     club;
  const _CommunityCard({required this.col, required this.club});

  @override
  State<_CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<_CommunityCard> {
  late bool _joined;

  @override
  void initState() {
    super.initState();
    _joined = widget.club.joined;
  }

  @override
  Widget build(BuildContext context) {
    final col  = AppColors.of(context);
    final club = widget.club;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            width: 46, height: 46,
            decoration: BoxDecoration(
              color:        club.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.group, color: club.color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(club.name, style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('${club.members} members', style: TextStyle(color: col.textSecondary, fontSize: 13)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _joined = !_joined),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:  const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
              decoration: BoxDecoration(
                color:        _joined ? col.surface : col.accent,
                borderRadius: BorderRadius.circular(12),
                border:       _joined ? Border.all(color: col.textSecondary.withValues(alpha: 0.3)) : null,
              ),
              child: Text(
                _joined ? 'Joined' : 'Join',
                style: TextStyle(
                  color:      _joined ? col.textSecondary : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize:   13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
