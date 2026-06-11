import 'package:flutter/material.dart';
import '../theme.dart';

class OpportunitiesScreen extends StatefulWidget {
  static const routeName = '/opportunities';
  const OpportunitiesScreen({super.key});

  @override
  State<OpportunitiesScreen> createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'Internships', 'Competitions', 'Grants'];

  static const _opportunities = [
    _Opportunity(type: 'Competition', typeColor: Color(0xFF5C6BC0),
        title: 'Pan-African AI Challenge',    org: 'AfriLabs',
        prize: 'Prize: \$5,000',             deadline: 'June 12, 2026',
        location: 'Virtual',                  category: 'Competitions'),
    _Opportunity(type: 'Grant',       typeColor: Color(0xFF66BB6A),
        title: 'Social Impact Grant 2026',    org: 'ALU Foundation',
        prize: 'Up to \$10,000',             deadline: 'June 30, 2026',
        location: 'Open to all students',     category: 'Grants'),
    _Opportunity(type: 'Internship',  typeColor: Color(0xFF26A69A),
        title: 'Google Africa Developer Program', org: 'Google',
        prize: 'Paid • Stipend provided',    deadline: 'July 1, 2026',
        location: 'Nairobi / Remote',         category: 'Internships'),
    _Opportunity(type: 'Competition', typeColor: Color(0xFF5C6BC0),
        title: 'HULT Prize 2026',             org: 'HULT International',
        prize: 'Prize: \$1M seed funding',   deadline: 'July 15, 2026',
        location: 'Global — campus round',    category: 'Competitions'),
    _Opportunity(type: 'Internship',  typeColor: Color(0xFF26A69A),
        title: 'McKinsey Next Generation Women Leaders', org: 'McKinsey & Company',
        prize: 'Paid • Travel included',     deadline: 'July 20, 2026',
        location: 'Johannesburg / Remote',    category: 'Internships'),
    _Opportunity(type: 'Grant',       typeColor: Color(0xFF66BB6A),
        title: 'ALU Research Grant',          org: 'ALU',
        prize: 'Up to \$3,000',             deadline: 'August 1, 2026',
        location: 'Open to all students',     category: 'Grants'),
  ];

  List<_Opportunity> get _visible => _filter == 'All'
      ? _opportunities
      : _opportunities.where((o) => o.category == _filter).toList();

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
            _buildFilters(col),
            const SizedBox(height: 4),
            Expanded(
              child: ListView.builder(
                padding:   const EdgeInsets.fromLTRB(20, 8, 20, 100),
                itemCount: _visible.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child:   _OpportunityCard(opp: _visible[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppColors col) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 20, 16),
      child: Row(
        children: [
          IconButton(
            icon:      Icon(Icons.arrow_back_ios_new, color: col.textPrimary, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(child: Text('Opportunities',
              style: TextStyle(color: col.textPrimary, fontSize: 26, fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.tune, color: col.textSecondary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(AppColors col) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: _filters.map((f) {
          final selected = _filter == f;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => setState(() => _filter = f),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding:  const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                decoration: BoxDecoration(
                  color:        selected ? col.accent : col.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(f,
                    style: TextStyle(
                      color:      selected ? Colors.black : col.textSecondary,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                      fontSize:   13,
                    )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Opportunity {
  final String type;
  final Color  typeColor;
  final String title;
  final String org;
  final String prize;
  final String deadline;
  final String location;
  final String category;

  const _Opportunity({
    required this.type,
    required this.typeColor,
    required this.title,
    required this.org,
    required this.prize,
    required this.deadline,
    required this.location,
    required this.category,
  });
}

class _OpportunityCard extends StatelessWidget {
  final _Opportunity opp;
  const _OpportunityCard({required this.opp});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color:        opp.typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(_typeIcon(opp.type), color: opp.typeColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(opp.org,   style: TextStyle(color: col.textSecondary, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(opp.title, style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color:        opp.typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(opp.type, style: TextStyle(color: opp.typeColor, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: col.background, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(child: _InfoChip(icon: Icons.emoji_events_outlined,   label: opp.prize,    color: col.accent)),
                const SizedBox(width: 12),
                Expanded(child: _InfoChip(icon: Icons.calendar_today_outlined, label: opp.deadline, color: Colors.redAccent)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 13, color: col.textSecondary),
              const SizedBox(width: 4),
              Text(opp.location, style: TextStyle(color: col.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(12)),
              child: const Center(
                child: Text('Apply Now', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _typeIcon(String type) {
    switch (type) {
      case 'Competition': return Icons.emoji_events;
      case 'Grant':       return Icons.volunteer_activism;
      case 'Internship':  return Icons.work_outline;
      default:            return Icons.star_outline;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String   label;
  final Color    color;
  const _InfoChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 5),
        Expanded(child: Text(label,
            style: TextStyle(color: col.textPrimary, fontSize: 12, fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
