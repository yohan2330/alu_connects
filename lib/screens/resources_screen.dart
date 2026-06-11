import 'package:flutter/material.dart';
import '../theme.dart';

class ResourcesScreen extends StatefulWidget {
  static const routeName = '/resources';
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'Notes', 'Templates', 'Tools', 'Guides'];

  static const _resources = [
    _Resource(title: 'ALU Academic Writing Guide',    category: 'Guides',     type: 'PDF',   size: '2.4 MB',  author: 'Academic Office',        icon: Icons.menu_book,    color: Color(0xFF5C6BC0), downloads: 1240),
    _Resource(title: 'Business Plan Template 2026',   category: 'Templates',  type: 'DOCX',  size: '850 KB',  author: 'Entrepreneurship Club',   icon: Icons.description,  color: Color(0xFFF9A825), downloads: 876),
    _Resource(title: 'Python for Data Science — Notes',category: 'Notes',     type: 'PDF',   size: '5.1 MB',  author: 'Tech & Innovation Hub',   icon: Icons.code,         color: Color(0xFF26A69A), downloads: 2103),
    _Resource(title: 'Figma UI Kit — ALU Design System',category: 'Tools',    type: 'Figma', size: 'Online',  author: 'Creative Nexus',         icon: Icons.palette,      color: Color(0xFFEF5350), downloads: 654),
    _Resource(title: 'Leadership Essentials Handbook', category: 'Guides',    type: 'PDF',   size: '3.2 MB',  author: 'Women in Leadership',    icon: Icons.emoji_people, color: Color(0xFF7B1FA2), downloads: 987),
    _Resource(title: 'CV & Cover Letter Templates',    category: 'Templates', type: 'ZIP',   size: '1.8 MB',  author: 'Career Services',        icon: Icons.work_outline, color: Color(0xFF66BB6A), downloads: 3241),
  ];

  List<_Resource> get _visible => _filter == 'All'
      ? _resources
      : _resources.where((r) => r.category == _filter).toList();

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
                  child:   _ResourceCard(resource: _visible[i]),
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
          Expanded(child: Text('Resources',
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

class _Resource {
  final String   title;
  final String   category;
  final String   type;
  final String   size;
  final String   author;
  final IconData icon;
  final Color    color;
  final int      downloads;

  const _Resource({
    required this.title,
    required this.category,
    required this.type,
    required this.size,
    required this.author,
    required this.icon,
    required this.color,
    required this.downloads,
  });
}

class _ResourceCard extends StatelessWidget {
  final _Resource resource;
  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color:        resource.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(resource.icon, color: resource.color, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color:        resource.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(resource.type,
                          style: TextStyle(color: resource.color, fontSize: 10, fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 6),
                    Text(resource.size, style: TextStyle(color: col.textMuted, fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 5),
                Text(resource.title,
                    style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(Icons.person_outline,   size: 12, color: col.textSecondary),
                    const SizedBox(width: 3),
                    Text(resource.author, style: TextStyle(color: col.textSecondary, fontSize: 12)),
                    const SizedBox(width: 10),
                    Icon(Icons.download_outlined, size: 12, color: col.textSecondary),
                    const SizedBox(width: 3),
                    Text('${resource.downloads}', style: TextStyle(color: col.textSecondary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: col.accent, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.download_rounded, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }
}
