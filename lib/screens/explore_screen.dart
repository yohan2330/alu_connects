import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/auth_service.dart';
import 'communities_screen.dart';
import 'event_detail_screen.dart';
import 'events_screen.dart';
import 'jobs_screen.dart';
import 'mentors_screen.dart';
import 'notifications_screen.dart';
import 'opportunities_screen.dart';
import 'resources_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? _userRole;
  bool    _isSearching  = false;
  String  _searchQuery  = '';
  final   _searchCtrl   = TextEditingController();
  final   _searchFocus  = FocusNode();

  // ── Searchable pool ────────────────────────────────────────────────────────

  static const _searchPool = [
    // Categories
    _SR(title: 'Events',        subtitle: '18 upcoming events on campus',      icon: Icons.event_rounded,           color: Color(0xFFE65100), type: 'Category',    route: EventsScreen.routeName),
    _SR(title: 'Opportunities', subtitle: '24 open opportunities',             icon: Icons.emoji_events_rounded,    color: Color(0xFF00695C), type: 'Category',    route: OpportunitiesScreen.routeName),
    _SR(title: 'Communities',   subtitle: '7 active clubs',                   icon: Icons.group_rounded,           color: Color(0xFFB8860B), type: 'Category',    route: CommunitiesScreen.routeName),
    _SR(title: 'Jobs',          subtitle: '12 job listings',                  icon: Icons.business_center_rounded, color: Color(0xFF1B5E20), type: 'Category',    route: JobsScreen.routeName),
    _SR(title: 'Mentors',       subtitle: '50+ alumni mentors',               icon: Icons.school_rounded,          color: Color(0xFF4A148C), type: 'Category',    route: MentorsScreen.routeName),
    _SR(title: 'Resources',     subtitle: '100+ documents and guides',        icon: Icons.menu_book_rounded,       color: Color(0xFF0D47A1), type: 'Category',    route: ResourcesScreen.routeName),
    // Events
    _SR(title: 'Debate Night: AI vs Human Creativity', subtitle: 'Event · ALU Debate Society · Room 204',          icon: Icons.record_voice_over_rounded, color: Color(0xFF5C6BC0), type: 'Event', route: EventDetailScreen.routeName),
    _SR(title: 'Design Jam: Build for Impact',         subtitle: 'Event · Creative Nexus · Block B, Jun 20',       icon: Icons.palette_rounded,           color: Color(0xFFEF5350), type: 'Event', route: EventDetailScreen.routeName),
    _SR(title: 'Pitch Night',                          subtitle: 'Event · ALU Entrepreneurship · Kigali Campus',   icon: Icons.lightbulb_rounded,         color: Color(0xFFF9A825), type: 'Event', route: EventDetailScreen.routeName),
    _SR(title: 'Flutter & Firebase Workshop',          subtitle: 'Event · Tech Hub · Online',                      icon: Icons.computer_rounded,          color: Color(0xFF26A69A), type: 'Event', route: EventDetailScreen.routeName),
    _SR(title: 'Women in Tech Meetup',                 subtitle: 'Event · Women+ · Mauritius Campus',              icon: Icons.people_rounded,            color: Color(0xFFEC407A), type: 'Event', route: EventDetailScreen.routeName),
    // Opportunities
    _SR(title: 'Pan-African AI Challenge',           subtitle: 'Opportunity · AfriLabs · Prize \$5,000',           icon: Icons.emoji_events_rounded,      color: Color(0xFF26A69A), type: 'Opportunity', route: OpportunitiesScreen.routeName),
    _SR(title: 'Google Africa Developer Scholarship',subtitle: 'Opportunity · Google · Remote, stipend included',  icon: Icons.school_rounded,            color: Color(0xFF42A5F5), type: 'Opportunity', route: OpportunitiesScreen.routeName),
    _SR(title: 'Social Impact Grant 2026',           subtitle: 'Opportunity · ALU Foundation · Up to \$10,000',   icon: Icons.volunteer_activism_rounded, color: Color(0xFF66BB6A), type: 'Opportunity', route: OpportunitiesScreen.routeName),
    // Clubs
    _SR(title: 'ALU Debate Society',    subtitle: 'Club · 120 members',  icon: Icons.record_voice_over_rounded, color: Color(0xFF5C6BC0), type: 'Club', route: CommunitiesScreen.routeName),
    _SR(title: 'Entrepreneurship Club', subtitle: 'Club · 85 members',   icon: Icons.lightbulb_rounded,         color: Color(0xFFF9A825), type: 'Club', route: CommunitiesScreen.routeName),
    _SR(title: 'Women+ in Tech',        subtitle: 'Club · 67 members',   icon: Icons.people_rounded,            color: Color(0xFFEC407A), type: 'Club', route: CommunitiesScreen.routeName),
    _SR(title: 'Tech Hub',              subtitle: 'Club · 94 members',   icon: Icons.computer_rounded,          color: Color(0xFF26A69A), type: 'Club', route: CommunitiesScreen.routeName),
    _SR(title: 'Creative Nexus',        subtitle: 'Club · 45 members',   icon: Icons.palette_rounded,           color: Color(0xFFEF5350), type: 'Club', route: CommunitiesScreen.routeName),
    _SR(title: 'Pan-African Students',  subtitle: 'Club · 200 members',  icon: Icons.public_rounded,            color: Color(0xFF66BB6A), type: 'Club', route: CommunitiesScreen.routeName),
    // People
    _SR(title: 'Chisom O.', subtitle: 'Software Engineer · ALU Mauritius', icon: Icons.person_rounded, color: Color(0xFF26A69A), type: 'Person', route: null),
    _SR(title: 'Fatima R.', subtitle: 'Entrepreneur · ALU Kigali',        icon: Icons.person_rounded, color: Color(0xFFF9A825), type: 'Person', route: null),
    _SR(title: 'James K.',  subtitle: 'Professor · ALU',                  icon: Icons.person_rounded, color: Color(0xFFEF5350), type: 'Person', route: null),
    _SR(title: 'Nadia T.',  subtitle: 'Product Manager · ALU',            icon: Icons.person_rounded, color: Color(0xFF7B1FA2), type: 'Person', route: null),
  ];

  // ── Static explore data ────────────────────────────────────────────────────

  static const _categories = [
    _Category(label: 'Events',        subtitle: '18 upcoming',    icon: Icons.event_rounded,           color: Color(0xFFE65100), route: EventsScreen.routeName),
    _Category(label: 'Opportunities', subtitle: '24 open',        icon: Icons.emoji_events_rounded,    color: Color(0xFF00695C), route: OpportunitiesScreen.routeName),
    _Category(label: 'Communities',   subtitle: '7 active clubs', icon: Icons.group_rounded,           color: Color(0xFFB8860B), route: CommunitiesScreen.routeName),
    _Category(label: 'Jobs',          subtitle: '12 listings',    icon: Icons.business_center_rounded, color: Color(0xFF1B5E20), route: JobsScreen.routeName),
    _Category(label: 'Mentors',       subtitle: '50+ alumni',     icon: Icons.school_rounded,          color: Color(0xFF4A148C), route: MentorsScreen.routeName),
    _Category(label: 'Resources',     subtitle: '100+ docs',      icon: Icons.menu_book_rounded,       color: Color(0xFF0D47A1), route: ResourcesScreen.routeName),
  ];

  static const _trending = [
    _TrendingTopic(label: '#Hackathon2026', count: '340'),
    _TrendingTopic(label: '#PitchNight',    count: '218'),
    _TrendingTopic(label: '#ALULeads',      count: '195'),
    _TrendingTopic(label: '#WomenInTech',   count: '170'),
    _TrendingTopic(label: '#AfricanAI',     count: '143'),
  ];

  static const _people = [
    _Person(name: 'Chisom O.', role: 'Software Eng.', initials: 'CO', color: Color(0xFF26A69A)),
    _Person(name: 'Fatima R.', role: 'Entrepreneur',  initials: 'FR', color: Color(0xFFF9A825)),
    _Person(name: 'James K.',  role: 'Professor',     initials: 'JK', color: Color(0xFFEF5350)),
    _Person(name: 'Nadia T.',  role: 'Product Mgr.',  initials: 'NT', color: Color(0xFF7B1FA2)),
  ];

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _loadRole();
    _searchCtrl.addListener(() {
      setState(() => _searchQuery = _searchCtrl.text);
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _loadRole() async {
    final role = await AuthService.currentUserRole();
    if (mounted) setState(() => _userRole = role);
  }

  void _startSearch() {
    setState(() => _isSearching = true);
    _searchFocus.requestFocus();
  }

  void _stopSearch() {
    _searchCtrl.clear();
    _searchFocus.unfocus();
    setState(() { _isSearching = false; _searchQuery = ''; });
  }

  List<_SR> get _results {
    if (_searchQuery.isEmpty) return [];
    final q = _searchQuery.toLowerCase();
    return _searchPool.where((r) =>
      r.title.toLowerCase().contains(q)   ||
      r.subtitle.toLowerCase().contains(q) ||
      r.type.toLowerCase().contains(q),
    ).toList();
  }

  // ── "For You" section ──────────────────────────────────────────────────────

  ({List<_Category> picks, String reason}) get _forYou {
    switch (_userRole) {
      case 'Entrepreneur':     return (picks: [_categories[1], _categories[3]], reason: 'For entrepreneurs');
      case 'Club Leader':      return (picks: [_categories[2], _categories[0]], reason: 'For club leaders');
      case 'Event Organizer':  return (picks: [_categories[0], _categories[2]], reason: 'For event organizers');
      case 'Academic Team':    return (picks: [_categories[5], _categories[4]], reason: 'For academic team');
      case 'Student Community':return (picks: [_categories[2], _categories[0]], reason: 'For community members');
      default:                 return (picks: [_categories[4], _categories[0]], reason: 'Recommended for you');
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildSearchBar(context)),
            if (_isSearching) ...[
              SliverToBoxAdapter(child: _buildSearchResults(context)),
            ] else ...[
              if (_userRole != null)
                SliverToBoxAdapter(child: _buildForYouSection(context)),
              SliverToBoxAdapter(child: _buildCategoriesSection(context)),
              SliverToBoxAdapter(child: _buildTrendingSection(context)),
              SliverToBoxAdapter(child: _buildPeopleSection(context)),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final col = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isSearching
                ? Text('Search', key: const ValueKey('search'),
                    style: TextStyle(color: col.textPrimary, fontSize: 28, fontWeight: FontWeight.bold))
                : Column(
                    key: const ValueKey('discover'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Discover',
                          style: TextStyle(color: col.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('What are you looking for?',
                          style: TextStyle(color: col.textSecondary, fontSize: 13)),
                    ],
                  ),
          ),
          // Bell icon with live unread badge
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, NotificationsScreen.routeName),
            child: ValueListenableBuilder<int>(
              valueListenable: unreadNotificationsNotifier,
              builder: (_, count, _) => Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(14)),
                    child: Icon(Icons.notifications_rounded, color: col.textPrimary, size: 22),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 2, top: 2,
                      child: Container(
                        width: 16, height: 16,
                        decoration: BoxDecoration(
                          color:  Colors.redAccent,
                          shape:  BoxShape.circle,
                          border: Border.all(color: col.background, width: 1.5),
                        ),
                        child: Center(
                          child: Text('$count',
                              style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
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

  Widget _buildSearchBar(BuildContext context) {
    final col = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Container(
        decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(18)),
        padding:    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: _isSearching ? col.accent : col.textSecondary, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: _isSearching
                  ? TextField(
                      controller:  _searchCtrl,
                      focusNode:   _searchFocus,
                      style:       TextStyle(color: col.textPrimary, fontSize: 14),
                      decoration:  InputDecoration(
                        hintText:       'Search events, clubs, people...',
                        hintStyle:      TextStyle(color: col.textSecondary, fontSize: 14),
                        border:         InputBorder.none,
                        isDense:        true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      textInputAction: TextInputAction.search,
                    )
                  : GestureDetector(
                      onTap: _startSearch,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text('Search events, clubs, people...',
                            style: TextStyle(color: col.textSecondary, fontSize: 14)),
                      ),
                    ),
            ),
            if (_isSearching)
              GestureDetector(
                onTap: _stopSearch,
                child: Icon(Icons.close_rounded, color: col.textSecondary, size: 20),
              )
            else
              Icon(Icons.tune_rounded, color: col.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    final col     = AppColors.of(context);
    final results = _results;

    if (_searchQuery.isEmpty) {
      return _buildSearchSuggestions(context, col);
    }

    if (results.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Center(
          child: Column(
            children: [
              Icon(Icons.search_off_rounded, color: col.textMuted, size: 48),
              const SizedBox(height: 14),
              Text('No results for "$_searchQuery"',
                  style: TextStyle(color: col.textSecondary, fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Text('Try different keywords', style: TextStyle(color: col.textMuted, fontSize: 13)),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Text('${results.length} result${results.length == 1 ? '' : 's'}',
              style: TextStyle(color: col.textMuted, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        ),
        ...results.map((r) => _buildResultTile(context, col, r)),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildSearchSuggestions(BuildContext context, AppColors col) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Try searching for',
              style: TextStyle(color: col.textMuted, fontSize: 12, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8, runSpacing: 8,
            children: [
              'Events', 'Hackathon', 'Mentors', 'Scholarship',
              'Debate', 'Women in Tech', 'Pitch Night', 'Jobs',
            ].map((s) => GestureDetector(
              onTap: () {
                _searchCtrl.text = s;
                _searchCtrl.selection = TextSelection.collapsed(offset: s.length);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color:        col.surface,
                  borderRadius: BorderRadius.circular(20),
                  border:       Border.all(color: col.border),
                ),
                child: Text(s, style: TextStyle(color: col.textPrimary, fontSize: 13)),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultTile(BuildContext context, AppColors col, _SR r) {
    return GestureDetector(
      onTap: r.route != null ? () => Navigator.pushNamed(context, r.route!) : null,
      child: Container(
        margin:  const EdgeInsets.fromLTRB(20, 0, 20, 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color:        r.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(r.icon, color: r.color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(r.title,
                      style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                  const SizedBox(height: 3),
                  Text(r.subtitle,
                      style: TextStyle(color: col.textSecondary, fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:        r.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(r.type, style: TextStyle(color: r.color, fontSize: 10, fontWeight: FontWeight.w700)),
            ),
            if (r.route != null) ...[
              const SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded, color: col.textMuted, size: 18),
            ],
          ],
        ),
      ),
    );
  }

  // ── Normal explore sections ────────────────────────────────────────────────

  Widget _buildForYouSection(BuildContext context) {
    final col    = AppColors.of(context);
    final forYou = _forYou;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome_rounded, color: col.accent, size: 16),
              const SizedBox(width: 6),
              Text(forYou.reason,
                  style: TextStyle(color: col.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _CategoryCard(cat: forYou.picks[0], featured: true)),
              const SizedBox(width: 12),
              Expanded(child: _CategoryCard(cat: forYou.picks[1], featured: true)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Browse',
              style: TextStyle(color: AppColors.of(context).textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          for (int row = 0; row < 3; row++) ...[
            if (row > 0) const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _CategoryCard(cat: _categories[row * 2])),
                const SizedBox(width: 12),
                Expanded(child: _CategoryCard(cat: _categories[row * 2 + 1])),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrendingSection(BuildContext context) {
    final col = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              children: [
                Icon(Icons.local_fire_department_rounded, color: col.accent, size: 20),
                const SizedBox(width: 8),
                Text('Trending Now',
                    style: TextStyle(color: col.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: _trending.map((t) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color:        col.surface,
                    borderRadius: BorderRadius.circular(14),
                    border:       Border.all(color: col.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(t.label, style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color:        col.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(t.count, style: TextStyle(color: col.accent, fontSize: 11, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeopleSection(BuildContext context) {
    final col = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('People to Follow',
                    style: TextStyle(color: col.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('See all',
                    style: TextStyle(color: col.accent, fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: _people.map((p) => Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _PersonCard(person: p),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final _Category cat;
  final bool      featured;
  const _CategoryCard({required this.cat, this.featured = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, cat.route),
      child: Container(
        height: featured ? 120 : 100,
        decoration: BoxDecoration(
          color:        cat.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: featured
              ? [BoxShadow(color: cat.color.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))]
              : null,
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10, top: -10,
              child: Icon(cat.icon, size: 80, color: Colors.white.withValues(alpha: 0.12)),
            ),
            if (featured)
              Positioned(
                top: 12, right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color:        Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('For you', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.end,
                children: [
                  Icon(cat.icon, color: Colors.white, size: 22),
                  const SizedBox(height: 6),
                  Text(cat.label,    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(cat.subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Person card ───────────────────────────────────────────────────────────────

class _PersonCard extends StatefulWidget {
  final _Person person;
  const _PersonCard({required this.person});

  @override
  State<_PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<_PersonCard> {
  bool _following = false;

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    final p   = widget.person;
    return Container(
      width:   130,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          CircleAvatar(
            radius:          26,
            backgroundColor: p.color.withValues(alpha: 0.2),
            child: Text(p.initials, style: TextStyle(color: p.color, fontWeight: FontWeight.bold, fontSize: 15)),
          ),
          const SizedBox(height: 10),
          Text(p.name, style: TextStyle(color: col.textPrimary,   fontWeight: FontWeight.w600, fontSize: 13), textAlign: TextAlign.center),
          const SizedBox(height: 3),
          Text(p.role, style: TextStyle(color: col.textSecondary, fontSize: 11), textAlign: TextAlign.center),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _following = !_following),
            child: AnimatedContainer(
              duration:  const Duration(milliseconds: 180),
              width:     double.infinity,
              padding:   const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color:        _following ? col.surface : col.accent,
                borderRadius: BorderRadius.circular(10),
                border:       _following ? Border.all(color: col.border) : null,
              ),
              child: Center(
                child: Text(
                  _following ? 'Following' : 'Follow',
                  style: TextStyle(
                    color:      _following ? col.textSecondary : Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize:   12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data models ───────────────────────────────────────────────────────────────

class _SR {
  final String   title;
  final String   subtitle;
  final IconData icon;
  final Color    color;
  final String   type;
  final String?  route;
  const _SR({required this.title, required this.subtitle, required this.icon, required this.color, required this.type, required this.route});
}

class _Category {
  final String   label;
  final String   subtitle;
  final IconData icon;
  final Color    color;
  final String   route;
  const _Category({required this.label, required this.subtitle, required this.icon, required this.color, required this.route});
}

class _TrendingTopic {
  final String label;
  final String count;
  const _TrendingTopic({required this.label, required this.count});
}

class _Person {
  final String name;
  final String role;
  final String initials;
  final Color  color;
  const _Person({required this.name, required this.role, required this.initials, required this.color});
}
