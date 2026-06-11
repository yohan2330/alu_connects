import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/auth_service.dart';
import 'main_tab_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey                  = GlobalKey<FormState>();
  final _nameController           = TextEditingController();
  final _emailController          = TextEditingController();
  final _passwordController       = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  final List<String> _roles = [
    'Club Leader', 'Event Organizer', 'Entrepreneur',
    'Student Community', 'Academic Team', 'Member',
  ];
  String _selectedRole = 'Club Leader';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Passwords do not match.')));
      return;
    }
    setState(() => _isLoading = true);
    final success = await AuthService.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _selectedRole,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);
    if (success) {
      Navigator.pushReplacementNamed(context, MainTabScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This email already exists or the form is invalid.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      appBar: AppBar(
        backgroundColor: col.surface,
        elevation: 0,
        title: const Text('Create account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                style:      TextStyle(color: col.textPrimary),
                decoration: const InputDecoration(labelText: 'Full name', hintText: 'Aline Umuhoza'),
                validator:  (v) => (v == null || v.trim().isEmpty) ? 'Name is required.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller:  _emailController,
                keyboardType: TextInputType.emailAddress,
                style:       TextStyle(color: col.textPrimary),
                decoration:  const InputDecoration(labelText: 'Email', hintText: 'name@alu.edu'),
                validator:   (v) => (v == null || v.trim().isEmpty) ? 'Email is required.' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedRole,
                decoration:   const InputDecoration(labelText: 'Role'),
                items: _roles.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                onChanged: (v) { if (v != null) setState(() => _selectedRole = v); },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller:  _passwordController,
                obscureText: true,
                style:       TextStyle(color: col.textPrimary),
                decoration:  const InputDecoration(labelText: 'Password', hintText: 'Create a password'),
                validator:   (v) => (v == null || v.trim().length < 6) ? 'Password must be at least 6 characters.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller:  _confirmPasswordController,
                obscureText: true,
                style:       TextStyle(color: col.textPrimary),
                decoration:  const InputDecoration(labelText: 'Confirm Password', hintText: 'Re-enter password'),
                validator:   (v) => (v == null || v.trim().isEmpty) ? 'Please confirm your password.' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                    : const Text('Create Account'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child:     Text('Back to login', style: TextStyle(color: col.accent)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
