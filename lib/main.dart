import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/main_tab_screen.dart';
import 'screens/create_post_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/alu_signin_screen.dart';
import 'screens/signup_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const ALUConnectApp());
}

class ALUConnectApp extends StatelessWidget {
  const ALUConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const AuthGate(),
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        AluSignInScreen.routeName: (_) => const AluSignInScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        MainTabScreen.routeName: (_) => const MainTabScreen(),
        CreatePostScreen.routeName: (_) => const CreatePostScreen(),
        EventDetailScreen.routeName: (_) => const EventDetailScreen(),
        ChatDetailScreen.routeName: (_) => const ChatDetailScreen(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService.isSignedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator(color: AppColors.accent)),
          );
        }

        if (snapshot.data == true) {
          return const MainTabScreen();
        }

        return const LoginScreen();
      },
    );
  }
}
