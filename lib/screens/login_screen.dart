import 'package:flutter/material.dart';
import '../theme.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return Scaffold(
      backgroundColor: col.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 36),
              const SizedBox(height: 64),
              Center(
                child: Container(
                  width: 96, height: 96,
                  decoration: BoxDecoration(
                    color:        col.accent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.change_circle, size: 52, color: Colors.black),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'ALU Intercampus Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:   28,
                  fontWeight: FontWeight.bold,
                  color:      col.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Connect. Collaborate. Lead Together.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: col.textSecondary),
              ),
              const Spacer(),
              ElevatedButton.icon(
                icon:      const Icon(Icons.school),
                label:     const Text('Sign in with ALU Account'),
                onPressed: () => Navigator.pushNamed(context, '/alu-sign-in'),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'OR CONTINUE WITH',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: col.textSecondary),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side:    BorderSide(color: col.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape:   RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon:      Icon(Icons.g_mobiledata, color: col.textPrimary),
                      label:     Text('Google', style: TextStyle(color: col.textPrimary)),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side:    BorderSide(color: col.border),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape:   RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon:      Icon(Icons.apple, color: col.textPrimary),
                      label:     Text('Apple', style: TextStyle(color: col.textPrimary)),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/sign-up'),
                child: Text(
                  'New here? Create account',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: col.accent, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
