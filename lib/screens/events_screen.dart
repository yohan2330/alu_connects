import 'package:flutter/material.dart';
import '../theme.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = '/events';
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'This Week', 'Online', 'Free'];

  static const _events = [
    _Event(tag: 'Workshop', tagColor: Color(0xFFF9A825),
        title: 'Pitch Night — Entrepreneurship Club', club: 'Entrepreneurship Club',
        date: '24', month: 'MAY', location: 'Kigali Campus • Building C',
        time: '6:00 PM – 9:00 PM', isOnline: false, isFree: false),
    _Event(tag: 'Debate', tagColor: Color(0xFF5C6BC0),
        title: 'AI vs Human Creativity — Debate Night', club: 'ALU Debate Society',
        date: '26', month: 'MAY', location: 'Room 204 • ALU Campus',
        time: '5:00 PM – 7:00 PM', isOnline: false, isFree: true),
    _Event(tag: 'Hackathon', tagColor: Color(0xFF26A69A),
        title: 'ALU Hackathon 2026 — Build for Africa', club: 'Tech & Innovation Hub',
        date: '10', month: 'JUN', location: 'Innovation Lab • ALU',
        time: 'All Day', isOnline: false, isFree: false),
    _Event(tag: 'Webinar', tagColor: Color(0xFF42A5F5),
        title: 'Women in Tech — Career Panel', club: 'Women in Leadership',
        date: '18', month: 'JUN', location: 'Zoom — Link on registration',
        time: '3:00 PM – 5:00 PM', isOnline: true, isFree: true),
    _Event(tag: 'Social', tagColor: Color(0xFFEF5350),
        title: 'Creative Jam — Design & Art Night', club: 'Creative Nexus',
        date: '20', month: 'JUN', location: 'Creative Studio • Block B',
        time: '7:00 PM – 10:00 PM', isOnline: false, isFree: true),
    _Event(tag: 'Networking', tagColor: Color(0xFF66BB6A),
        title: 'Pan-African Leadership Forum', club: 'Pan-African Society',
        date: '28', month: 'JUN', location: 'Virtual + Kigali Hub',
        time: '10:00 AM – 2:00 PM', isOnline: true, isFree: false),
  ];

  List<_Event> get _visible {
    if (_filter == 'All')       return _events;
    if (_filter == 'Online')    return _events.where((e) => e.isOnline).toList();
    if (_filter == 'Free')      return _events.where((e) => e.isFree).toList();
    if (_filter == 'This Week') return _events.take(2).toList();
    return _events;
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
                  child:   _EventCard(event: _visible[i]),
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
          Expanded(child: Text('Events',
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

class _Event {
  final String tag;
  final Color  tagColor;
  final String title;
  final String club;
  final String date;
  final String month;
  final String location;
  final String time;
  final bool   isOnline;
  final bool   isFree;

  const _Event({
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.club,
    required this.date,
    required this.month,
    required this.location,
    required this.time,
    required this.isOnline,
    required this.isFree,
  });
}

class _EventCard extends StatelessWidget {
  final _Event event;
  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Container(
      decoration: BoxDecoration(color: col.surface, borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: event.tagColor.withValues(alpha: 0.15),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(event.date,  style: TextStyle(color: event.tagColor, fontSize: 22, fontWeight: FontWeight.bold)),
                Text(event.month, style: TextStyle(color: event.tagColor.withValues(alpha: 0.7), fontSize: 11, fontWeight: FontWeight.w600)),
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
                      _Tag(label: event.tag, color: event.tagColor),
                      if (event.isOnline) ...[const SizedBox(width: 6), _Tag(label: 'Online', color: Colors.blueAccent)],
                      if (event.isFree)   ...[const SizedBox(width: 6), _Tag(label: 'Free',   color: Colors.greenAccent)],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(event.title,
                      style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600, fontSize: 14, height: 1.3)),
                  const SizedBox(height: 8),
                  _MetaRow(col: col, icon: Icons.location_on_outlined, text: event.location),
                  const SizedBox(height: 4),
                  _MetaRow(col: col, icon: Icons.schedule, text: event.time),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: col.accent, borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text('RSVP', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
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
}

class _Tag extends StatelessWidget {
  final String label;
  final Color  color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final AppColors col;
  final IconData  icon;
  final String    text;
  const _MetaRow({required this.col, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 13, color: col.textSecondary),
        const SizedBox(width: 5),
        Expanded(child: Text(text,
            style: TextStyle(color: col.textSecondary, fontSize: 12),
            overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
