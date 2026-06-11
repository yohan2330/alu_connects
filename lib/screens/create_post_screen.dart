import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../services/auth_service.dart';
import '../theme.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/create-post';
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final List<String> _postCategories = [
    'Event', 'Hackathon', 'Workshop', 'Startup Initiative',
    'Leadership Program', 'Internship', 'Community Announcement',
  ];
  String      _selectedCategory = 'Event';
  File?       _selectedImage;
  DateTime?   _selectedDate;
  TimeOfDay?  _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  final       _imagePicker  = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title:   const Text('Pick from Gallery'),
              onTap: () async {
                Navigator.pop(ctx);
                final img = await _imagePicker.pickImage(source: ImageSource.gallery);
                if (img != null) setState(() => _selectedImage = File(img.path));
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title:   const Text('Take a Photo'),
              onTap: () async {
                Navigator.pop(ctx);
                final img = await _imagePicker.pickImage(source: ImageSource.camera);
                if (img != null) setState(() => _selectedImage = File(img.path));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context:     context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate:   DateTime.now(),
      lastDate:    DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime() async {
    final picked = await showTimePicker(
      context:     context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null && picked != _selectedTime) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      appBar: AppBar(
        backgroundColor: col.surface,
        elevation:       0,
        title:           const Text('Create Post'),
        leading: IconButton(
          icon:      const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<bool>(
        future: AuthService.canPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final canPost = snapshot.data ?? false;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!canPost) ...[
                    Container(
                      width:   double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:        col.surface,
                        borderRadius: BorderRadius.circular(16),
                        border:       Border.all(color: col.border),
                      ),
                      child: Text(
                        'Only authorized roles can publish community activities and opportunities.',
                        style: TextStyle(color: col.textSecondary),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                  Text('Post type',
                      style: TextStyle(color: col.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: InputDecoration(
                      border:    const OutlineInputBorder(),
                      filled:    true,
                      fillColor: col.surface,
                    ),
                    items: _postCategories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (v) { if (v != null) setState(() => _selectedCategory = v); },
                  ),
                  const SizedBox(height: 24),
                  _buildCoverCard(col),
                  const SizedBox(height: 24),
                  Text('TITLE',
                      style: TextStyle(color: col.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const TextField(decoration: InputDecoration(hintText: 'Post Title')),
                  const SizedBox(height: 16),
                  Text('DESCRIPTION',
                      style: TextStyle(color: col.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: InputDecoration(hintText: 'Tell the campus community about it...'),
                    maxLines:   4,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectDate,
                          child: _buildInfoCard(col, icon: Icons.calendar_month,
                              label: _selectedDate != null
                                  ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
                                  : 'Select date'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: _selectTime,
                          child: _buildInfoCard(col, icon: Icons.access_time,
                              label: _selectedTime != null
                                  ? _selectedTime!.format(context)
                                  : '09:00 AM'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('LOCATION',
                      style: TextStyle(color: col.textSecondary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  const TextField(decoration: InputDecoration(hintText: 'Kigali Campus')),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    onPressed: canPost ? () {} : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.upload_file, color: Colors.black),
                        const SizedBox(width: 10),
                        Text(canPost ? 'Publish $_selectedCategory' : 'Publish'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoverCard(AppColors col) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border:       Border.all(color: col.border),
          color:        col.surface,
          image: _selectedImage != null
              ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover)
              : null,
        ),
        child: _selectedImage == null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_photo_alternate, size: 36, color: col.textSecondary),
                    const SizedBox(height: 10),
                    Text('Add cover image', style: TextStyle(color: col.textSecondary)),
                  ],
                ),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:        Colors.black.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon:      const Icon(Icons.edit, color: Colors.white, size: 32),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildInfoCard(AppColors col, {required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color:        col.surface,
        borderRadius: BorderRadius.circular(16),
        border:       Border.all(color: col.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: col.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(color: col.textPrimary, fontWeight: FontWeight.w600)),
          ),
          Icon(Icons.edit, size: 16, color: col.textSecondary),
        ],
      ),
    );
  }
}
