import 'package:flutter/material.dart';
import '../theme.dart';

class JobsScreen extends StatefulWidget {
  static const routeName = '/jobs';
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'Part-time', 'Remote', 'On-Campus'];

  static const _jobs = [
    _Job(title: 'Student Research Assistant', company: 'ALU Research Centre',
        type: 'On-Campus', typeColor: Color(0xFFF9A825), salary: 'RWF 80,000/mo',
        tags: ['Research', 'Flexible hours'], isRemote: false, isPartTime: true),
    _Job(title: 'Junior Frontend Developer', company: 'Andela',
        type: 'Remote', typeColor: Color(0xFF42A5F5), salary: '\$800/mo',
        tags: ['React', 'Flutter', 'Remote'], isRemote: true, isPartTime: true),
    _Job(title: 'Social Media & Content Intern', company: 'KLAB Rwanda',
        type: 'Part-time', typeColor: Color(0xFF66BB6A), salary: 'RWF 60,000/mo',
        tags: ['Marketing', 'Design'], isRemote: false, isPartTime: true),
    _Job(title: 'Data Analyst Intern', company: 'mPharma',
        type: 'Remote', typeColor: Color(0xFF42A5F5), salary: '\$500/mo',
        tags: ['Python', 'SQL', 'Remote'], isRemote: true, isPartTime: false),
    _Job(title: 'Campus Ambassador', company: 'Mastercard Foundation',
        type: 'On-Campus', typeColor: Color(0xFFF9A825), salary: 'Stipend + perks',
        tags: ['Leadership', 'Networking'], isRemote: false, isPartTime: true),
  ];

  List<_Job> get _visible {
    if (_filter == 'All')       return _jobs;
    if (_filter == 'Remote')    return _jobs.where((j) => j.isRemote).toList();
    if (_filter == 'Part-time') return _jobs.where((j) => j.isPartTime).toList();
    if (_filter == 'On-Campus') return _jobs.where((j) => !j.isRemote).toList();
    return _jobs;
  }

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
                  child:   _JobCard(job: _visible[i]),
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
          Expanded(child: Text('Jobs',
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

class _Job {
  final String       title;
  final String       company;
  final String       type;
  final Color        typeColor;
  final String       salary;
  final List<String> tags;
  final bool         isRemote;
  final bool         isPartTime;

  const _Job({
    required this.title,
    required this.company,
    required this.type,
    required this.typeColor,
    required this.salary,
    required this.tags,
    required this.isRemote,
    required this.isPartTime,
  });
}

class _JobCard extends StatelessWidget {
  final _Job job;
  const _JobCard({required this.job});

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
                width: 46, height: 46,
                decoration: BoxDecoration(
                  color:        job.typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(Icons.business_center, color: job.typeColor, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.company, style: TextStyle(color: col.textSecondary, fontSize: 12)),
                    const SizedBox(height: 2),
                    Text(job.title,   style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color:        job.typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(job.type, style: TextStyle(color: job.typeColor, fontSize: 11, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.payments_outlined, size: 14, color: col.accent),
              const SizedBox(width: 5),
              Text(job.salary, style: TextStyle(color: col.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8, runSpacing: 6,
            children: job.tags.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: col.background, borderRadius: BorderRadius.circular(8)),
              child: Text(t, style: TextStyle(color: col.textSecondary, fontSize: 12)),
            )).toList(),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    border:       Border.all(color: col.border),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text('Save',
                      style: TextStyle(color: col.textSecondary, fontWeight: FontWeight.w600, fontSize: 13))),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(12)),
                  child: const Center(child: Text('Apply Now',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
