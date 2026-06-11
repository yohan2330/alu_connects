import 'package:flutter/material.dart';
import '../theme.dart';
import 'communities_screen.dart';
import 'events_screen.dart';
import 'jobs_screen.dart';
import 'mentors_screen.dart';
import 'opportunities_screen.dart';
import 'resources_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  static const _categories = [
    _Category(label: 'Events',        subtitle: '18 upcoming',   icon: Icons.event_rounded,           color: Color(0xFFE65100), route: EventsScreen.routeName),
    _Category(label: 'Opportunities', subtitle: '24 open',       icon: Icons.emoji_events_rounded,    color: Color(0xFF00695C), route: OpportunitiesScreen.routeName),
    _Category(label: 'Communities',   subtitle: '7 active clubs',icon: Icons.group_rounded,           color: Color(0xFFB8860B), route: CommunitiesScreen.routeName),
    _Category(label: 'Jobs',          subtitle: '12 listings',   icon: Icons.business_center_rounded, color: Color(0xFF1B5E20), route: JobsScreen.routeName),
    _Category(label: 'Mentors',       subtitle: '50+ alumni',    icon: Icons.school_rounded,          color: Color(0xFF4A148C), route: MentorsScreen.routeName),
    _Category(label: 'Resources',     subtitle: '100+ docs',     icon: Icons.menu_book_rounded,       color: Color(0xFF0D47A1), route: ResourcesScreen.routeName),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(child: _buildSearchBar(context)),
            SliverToBoxAdapter(child: _buildCategoriesSection(context)),
            SliverToBoxAdapter(child: _buildTrendingSection(context)),
            SliverToBoxAdapter(child: _buildPeopleSection(context)),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Discover',
                  style: TextStyle(color: col.textPrimary, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text('What are you looking for?',
                  style: TextStyle(color: col.textSecondary, fontSize: 13)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(14)),
            child: Icon(Icons.notifications_none_rounded, color: col.textPrimary, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final col = AppColors.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
      child: Container(
        decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(18)),
        padding:    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.search_rounded,  color: col.textSecondary),
            const SizedBox(width: 12),
            Expanded(child: Text('Search events, clubs, people...',
                style: TextStyle(color: col.textSecondary, fontSize: 14))),
            Icon(Icons.tune_rounded, color: col.textSecondary, size: 20),
          ],
        ),
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

class _CategoryCard extends StatelessWidget {
  final _Category cat;
  const _CategoryCard({required this.cat});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, cat.route),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color:        cat.color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10, top: -10,
              child: Icon(cat.icon, size: 80, color: Colors.white.withValues(alpha: 0.12)),
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

class _Category {
  final String   label;
  final String   subtitle;
  final IconData icon;
  final Color    color;
  final String   route;

  const _Category({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.route,
  });
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
