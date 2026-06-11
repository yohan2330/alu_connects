import 'package:flutter/material.dart';
import '../theme.dart';

class MentorsScreen extends StatefulWidget {
  static const routeName = '/mentors';
  const MentorsScreen({super.key});

  @override
  State<MentorsScreen> createState() => _MentorsScreenState();
}

class _MentorsScreenState extends State<MentorsScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'Alumni', 'Professors', 'Industry'];

  static const _mentors = [
    _Mentor(name: 'Dr. Amara Diallo',  role: 'Professor of Computer Science',  category: 'Professors',
        avatarColor: Color(0xFF5C6BC0), initials: 'AD', expertise: ['AI & ML', 'Research', 'Python'],    available: true),
    _Mentor(name: 'Chisom Okafor',     role: 'Software Engineer @ Google',      category: 'Alumni',
        avatarColor: Color(0xFF26A69A), initials: 'CO', expertise: ['Android', 'Backend', 'Career'],     available: true),
    _Mentor(name: 'Fatima Al-Rashid', role: 'Founder & CEO, FinTech Africa',   category: 'Industry',
        avatarColor: Color(0xFFF9A825), initials: 'FA', expertise: ['Entrepreneurship', 'Finance', 'Strategy'], available: false),
    _Mentor(name: 'Prof. James Kimani',role: 'Head of Business Leadership',     category: 'Professors',
        avatarColor: Color(0xFFEF5350), initials: 'JK', expertise: ['Leadership', 'Strategy', 'MBA'],    available: true),
    _Mentor(name: 'Nadia Traoré',      role: 'Product Manager @ Flutterwave',   category: 'Alumni',
        avatarColor: Color(0xFF7B1FA2), initials: 'NT', expertise: ['Product', 'UX', 'Agile'],           available: true),
    _Mentor(name: 'Samuel Owusu',      role: 'Investment Analyst @ AfDB',       category: 'Industry',
        avatarColor: Color(0xFF2E7D32), initials: 'SO', expertise: ['Finance', 'Development', 'Policy'], available: false),
  ];

  List<_Mentor> get _visible => _filter == 'All'
      ? _mentors
      : _mentors.where((m) => m.category == _filter).toList();

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
                  child:   _MentorCard(mentor: _visible[i]),
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
          Expanded(child: Text('Mentors',
              style: TextStyle(color: col.textPrimary, fontSize: 26, fontWeight: FontWeight.bold))),
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

class _Mentor {
  final String       name;
  final String       role;
  final String       category;
  final Color        avatarColor;
  final String       initials;
  final List<String> expertise;
  final bool         available;

  const _Mentor({
    required this.name,
    required this.role,
    required this.category,
    required this.avatarColor,
    required this.initials,
    required this.expertise,
    required this.available,
  });
}

class _MentorCard extends StatelessWidget {
  final _Mentor mentor;
  const _MentorCard({required this.mentor});

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
              CircleAvatar(
                radius:          26,
                backgroundColor: mentor.avatarColor.withValues(alpha: 0.2),
                child: Text(mentor.initials,
                    style: TextStyle(color: mentor.avatarColor, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mentor.name, style: TextStyle(color: col.textPrimary,   fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 3),
                    Text(mentor.role, style: TextStyle(color: col.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(
                      color: mentor.available ? Colors.greenAccent : col.textSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mentor.available ? 'Available' : 'Busy',
                    style: TextStyle(
                      color:      mentor.available ? Colors.greenAccent : col.textSecondary,
                      fontSize:   10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8, runSpacing: 6,
            children: mentor.expertise.map((e) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color:        mentor.avatarColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(e, style: TextStyle(color: mentor.avatarColor, fontSize: 12, fontWeight: FontWeight.w600)),
            )).toList(),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11),
              decoration: BoxDecoration(
                color:        mentor.available ? col.accent : col.surface,
                borderRadius: BorderRadius.circular(12),
                border:       mentor.available ? null : Border.all(color: col.border),
              ),
              child: Center(
                child: Text(
                  mentor.available ? 'Request Session' : 'Join Waitlist',
                  style: TextStyle(
                    color:      mentor.available ? Colors.black : col.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize:   13,
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
