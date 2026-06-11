import 'package:flutter/material.dart';
import '../theme.dart';

enum _ItemType { event, opportunity, update }

class _Item {
  final _ItemType type;
  final String    club;
  final Color     color;
  final IconData  icon;
  final String    timeAgo;
  final String    title;
  final String    meta;
  final String?   day;
  final String?   month;
  final String?   countdown;
  final String?   prize;
  final String?   deadline;
  final bool      urgent;
  final int       likes;
  final int       comments;

  const _Item({
    required this.type,
    required this.club,
    required this.color,
    required this.icon,
    required this.timeAgo,
    required this.title,
    required this.meta,
    this.day,
    this.month,
    this.countdown,
    this.prize,
    this.deadline,
    this.urgent   = false,
    this.likes    = 0,
    this.comments = 0,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _clubs = [
    _Club('Debate',   Color(0xFF5C6BC0), Icons.record_voice_over_rounded),
    _Club('Entrep.',  Color(0xFFF9A825), Icons.lightbulb_rounded),
    _Club('Women+',   Color(0xFFEC407A), Icons.people_rounded),
    _Club('Tech Hub', Color(0xFF26A69A), Icons.computer_rounded),
    _Club('Creative', Color(0xFFEF5350), Icons.palette_rounded),
    _Club('Pan-AF',   Color(0xFF66BB6A), Icons.public_rounded),
  ];

  static const _feed = [
    _Item(
      type: _ItemType.event,
      club: 'ALU Debate Society',
      color: Color(0xFF5C6BC0),
      icon: Icons.record_voice_over_rounded,
      timeAgo: '2h ago',
      title: 'Debate Night: AI vs Human Creativity',
      meta: 'Room 204 · ALU Campus',
      day: '26', month: 'MAY', countdown: 'Tomorrow',
      likes: 34, comments: 9,
    ),
    _Item(
      type: _ItemType.opportunity,
      club: 'AfriLabs',
      color: Color(0xFF26A69A),
      icon: Icons.emoji_events_rounded,
      timeAgo: '4h ago',
      title: 'Pan-African AI Challenge',
      meta: 'Virtual · Open globally',
      prize: 'Prize: \$5,000', deadline: 'Jun 12, 2026', urgent: true,
      likes: 71, comments: 18,
    ),
    _Item(
      type: _ItemType.update,
      club: 'Entrepreneurship Club',
      color: Color(0xFFF9A825),
      icon: Icons.celebration_rounded,
      timeAgo: '1d ago',
      title: 'Recap: Pitch Night was a massive success!',
      meta: '250 members enjoyed an unforgettable evening of ideas, innovation and bold pitches. See the recap.',
      likes: 112, comments: 27,
    ),
    _Item(
      type: _ItemType.opportunity,
      club: 'Google',
      color: Color(0xFF42A5F5),
      icon: Icons.school_rounded,
      timeAgo: '1d ago',
      title: 'Google Africa Developer Scholarship',
      meta: 'Remote · Stipend included',
      prize: 'Fully funded', deadline: 'Jul 1, 2026',
      likes: 88, comments: 14,
    ),
    _Item(
      type: _ItemType.event,
      club: 'Creative Nexus',
      color: Color(0xFFEF5350),
      icon: Icons.palette_rounded,
      timeAgo: '2d ago',
      title: 'Design Jam: Build for Impact',
      meta: 'Creative Studio · Block B',
      day: '20', month: 'JUN', countdown: 'In 9 days',
      likes: 56, comments: 11,
    ),
    _Item(
      type: _ItemType.opportunity,
      club: 'ALU Foundation',
      color: Color(0xFF66BB6A),
      icon: Icons.volunteer_activism_rounded,
      timeAgo: '3d ago',
      title: 'Social Impact Grant 2026',
      meta: 'Open to all students',
      prize: 'Up to \$10,000', deadline: 'Jun 30, 2026',
      likes: 44, comments: 7,
    ),
  ];

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String get _greetingEmoji {
    final h = DateTime.now().hour;
    if (h < 12) return '☀️';
    if (h < 17) return '🌤️';
    return '🌙';
  }

  String _formatDate(DateTime dt) {
    const days   = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${days[dt.weekday - 1]}, ${months[dt.month - 1]} ${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(col)),
            SliverToBoxAdapter(child: _buildClubStories(col)),
            SliverToBoxAdapter(child: _buildHappeningSoon(col)),
            SliverToBoxAdapter(child: _buildFeedHeader(col)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final item   = _feed[i];
                  final isLast = i == _feed.length - 1;
                  Widget card = switch (item.type) {
                    _ItemType.event       => _EventCard(item: item),
                    _ItemType.opportunity => _OpportunityCard(item: item),
                    _ItemType.update      => _UpdateCard(item: item),
                  };
                  return Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, isLast ? 110 : 14),
                    child: card,
                  );
                },
                childCount: _feed.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(AppColors col) {
    final now = DateTime.now();
    return Stack(
      children: [
        Positioned(
          top: -30, right: -30,
          child: Container(
            width: 160, height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [col.accent.withValues(alpha: 0.18), Colors.transparent],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_greeting,
                            style: TextStyle(color: col.textSecondary, fontSize: 15, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 2),
                        Text('Aline! $_greetingEmoji',
                            style: TextStyle(color: col.textPrimary, fontSize: 30, fontWeight: FontWeight.bold, height: 1.1)),
                        const SizedBox(height: 6),
                        Text(_formatDate(now),
                            style: TextStyle(color: col.textMuted, fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(
                              shape:  BoxShape.circle,
                              border: Border.all(color: col.accent, width: 2),
                              color:  col.surface,
                            ),
                            child: Icon(Icons.person_rounded, color: col.accent, size: 28),
                          ),
                          Positioned(
                            right: 2, top: 2,
                            child: Container(
                              width: 12, height: 12,
                              decoration: BoxDecoration(
                                color:  Colors.redAccent,
                                shape:  BoxShape.circle,
                                border: Border.all(color: col.background, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _StatChip(col: col, icon: Icons.event_rounded,        label: '2 events today', color: const Color(0xFFF9A825)),
                    const SizedBox(width: 8),
                    _StatChip(col: col, icon: Icons.timer_rounded,        label: '3 deadlines',    color: Colors.redAccent),
                    const SizedBox(width: 8),
                    _StatChip(col: col, icon: Icons.dynamic_feed_rounded, label: '12 new posts',   color: const Color(0xFF42A5F5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClubStories(AppColors col) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
          child: Text('Your Clubs',
              style: TextStyle(color: col.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 82,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:         const EdgeInsets.symmetric(horizontal: 20),
            itemCount:       _clubs.length,
            itemBuilder: (_, i) => _ClubBubble(col: col, club: _clubs[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildHappeningSoon(AppColors col) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 7, height: 7,
                decoration: BoxDecoration(color: col.accent, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text('Happening Soon',
                  style: TextStyle(color: col.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1515187029135-18ee286d815b?auto=format&fit=crop&w=900&q=80',
                  height: 200,
                  width:  double.infinity,
                  fit:    BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(height: 200, color: col.surface),
                ),
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xEE000000), Color(0x33000000)],
                        begin:  Alignment.bottomCenter,
                        end:    Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16, left: 16, right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(8)),
                            child: const Text('ALU ENTREPRENEURSHIP',
                                style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color:        Colors.white.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.schedule_rounded, color: Colors.white, size: 12),
                                SizedBox(width: 4),
                                Text('In 2 days', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Pitch Night',
                          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.1)),
                      const SizedBox(height: 5),
                      const Row(
                        children: [
                          Icon(Icons.location_on_rounded, color: Colors.white60, size: 13),
                          SizedBox(width: 4),
                          Text('Kigali Campus · May 24, 2026',
                              style: TextStyle(color: Colors.white60, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedHeader(AppColors col) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('What\'s New',
              style: TextStyle(color: col.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          Text('See all',
              style: TextStyle(color: col.accent, fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── Feed Cards ────────────────────────────────────────────────────────────────

class _EventCard extends StatefulWidget {
  final _Item item;
  const _EventCard({required this.item});
  @override
  State<_EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<_EventCard> {
  bool _going = false;
  @override
  Widget build(BuildContext context) {
    final col  = AppColors.of(context);
    final item = widget.item;
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 64,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.15),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.day   ?? '', style: TextStyle(color: item.color, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(item.month ?? '', style: TextStyle(color: item.color.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  Icon(Icons.event_rounded, color: item.color, size: 18),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(item.club,    style: TextStyle(color: col.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Text(item.timeAgo, style: TextStyle(color: col.textMuted,     fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(item.title, style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.bold, fontSize: 14, height: 1.3)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 12, color: col.textMuted),
                        const SizedBox(width: 4),
                        Expanded(child: Text(item.meta, style: TextStyle(color: col.textMuted, fontSize: 12), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (item.countdown != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color:        item.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(item.countdown!,
                                style: TextStyle(color: item.color, fontSize: 11, fontWeight: FontWeight.w700)),
                          ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _going = !_going),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color:  _going ? item.color.withValues(alpha: 0.15) : item.color,
                              borderRadius: BorderRadius.circular(10),
                              border: _going ? Border.all(color: item.color) : null,
                            ),
                            child: Text(
                              _going ? 'Going ✓' : 'RSVP',
                              style: TextStyle(
                                color:      _going ? item.color : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:   12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OpportunityCard extends StatefulWidget {
  final _Item item;
  const _OpportunityCard({required this.item});
  @override
  State<_OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<_OpportunityCard> {
  bool _saved = false;
  @override
  Widget build(BuildContext context) {
    final col           = AppColors.of(context);
    final item          = widget.item;
    final deadlineColor = item.urgent ? Colors.redAccent : col.textSecondary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:         col.surface,
        borderRadius:  BorderRadius.circular(20),
        border: item.urgent ? Border.all(color: Colors.redAccent.withValues(alpha: 0.35)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42, height: 42,
                decoration: BoxDecoration(
                  color:        item.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.club,  style: TextStyle(color: col.textSecondary, fontSize: 12)),
                    Text(item.title, style: TextStyle(color: col.textPrimary,   fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _saved = !_saved),
                child: Icon(
                  _saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: _saved ? col.accent : col.textSecondary,
                  size:  22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(color: col.background, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_events_outlined, color: col.accent, size: 16),
                      const SizedBox(width: 6),
                      Text(item.prize ?? '',
                          style: TextStyle(color: col.textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color:        deadlineColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(item.urgent ? Icons.warning_rounded : Icons.calendar_today_rounded,
                          color: deadlineColor, size: 14),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(item.deadline ?? '',
                            style: TextStyle(color: deadlineColor, fontSize: 12, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 12, color: col.textMuted),
              const SizedBox(width: 4),
              Text(item.meta, style: TextStyle(color: col.textMuted, fontSize: 12)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(10)),
                child: const Text('Apply Now', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UpdateCard extends StatefulWidget {
  final _Item item;
  const _UpdateCard({required this.item});
  @override
  State<_UpdateCard> createState() => _UpdateCardState();
}

class _UpdateCardState extends State<_UpdateCard> {
  bool _liked = false;
  @override
  Widget build(BuildContext context) {
    final col  = AppColors.of(context);
    final item = widget.item;
    return Container(
      decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            decoration: BoxDecoration(
              color:        item.color,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius:          18,
                      backgroundColor: item.color.withValues(alpha: 0.15),
                      child: Icon(item.icon, color: item.color, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.club,    style: TextStyle(color: col.textPrimary,   fontWeight: FontWeight.w600, fontSize: 13)),
                          Text(item.timeAgo, style: TextStyle(color: col.textMuted,     fontSize: 11)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                      child: Text('Update', style: TextStyle(color: item.color, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(item.meta, style: TextStyle(color: col.textSecondary, fontSize: 14, height: 1.5)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _liked = !_liked),
                      child: Row(
                        children: [
                          Icon(_liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: _liked ? Colors.redAccent : col.textSecondary, size: 19),
                          const SizedBox(width: 5),
                          Text('${item.likes + (_liked ? 1 : 0)}',
                              style: TextStyle(color: _liked ? Colors.redAccent : col.textSecondary, fontSize: 13)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    Row(
                      children: [
                        Icon(Icons.chat_bubble_outline_rounded, color: col.textSecondary, size: 17),
                        const SizedBox(width: 5),
                        Text('${item.comments}', style: TextStyle(color: col.textSecondary, fontSize: 13)),
                      ],
                    ),
                    const Spacer(),
                    Icon(Icons.share_outlined, color: col.textSecondary, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Supporting Widgets ────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final AppColors col;
  final IconData  icon;
  final String    label;
  final Color     color;
  const _StatChip({required this.col, required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color:        col.surface,
        borderRadius: BorderRadius.circular(12),
        border:       Border.all(color: col.border, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: col.textPrimary, fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _Club {
  final String   name;
  final Color    color;
  final IconData icon;
  const _Club(this.name, this.color, this.icon);
}

class _ClubBubble extends StatelessWidget {
  final AppColors col;
  final _Club     club;
  const _ClubBubble({required this.col, required this.club});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54, height: 54,
            decoration: BoxDecoration(
              shape:  BoxShape.circle,
              border: Border.all(color: club.color, width: 2.5),
            ),
            child: CircleAvatar(
              backgroundColor: club.color.withValues(alpha: 0.12),
              child: Icon(club.icon, color: club.color, size: 22),
            ),
          ),
          const SizedBox(height: 6),
          Text(club.name,
              style: TextStyle(color: col.textSecondary, fontSize: 10),
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
