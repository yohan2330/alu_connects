import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/auth_service.dart';
import 'main_tab_screen.dart';

class AluSignInScreen extends StatefulWidget {
  static const routeName = '/alu-sign-in';

  const AluSignInScreen({super.key});

  @override
  State<AluSignInScreen> createState() => _AluSignInScreenState();
}

class _AluSignInScreenState extends State<AluSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final success = await AuthService.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, MainTabScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email and password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: const Text('ALU Account Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'name@alu.edu',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Sign In'),
              ),
              ,
              TextButton(
                onPressed: _isLoading ? null : () => Navigator.pop(context),
                child: const Text(
                  'Back to login',
                  style: TextStyle(color: AppColors.accent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
