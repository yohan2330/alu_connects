import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/main_tab_screen.dart';
import 'screens/create_post_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/chat_detail_screen.dart';

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
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        MainTabScreen.routeName: (_) => const MainTabScreen(),
        CreatePostScreen.routeName: (_) => const CreatePostScreen(),
        EventDetailScreen.routeName: (_) => const EventDetailScreen(),
        ChatDetailScreen.routeName: (_) => const ChatDetailScreen(),
      },
    );
  }
}
