import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';
import 'screens/main_tab_screen.dart';
import 'screens/create_post_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/alu_signin_screen.dart';
import 'screens/communities_screen.dart';
import 'screens/events_screen.dart';
import 'screens/jobs_screen.dart';
import 'screens/mentors_screen.dart';
import 'screens/opportunities_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/resources_screen.dart';
import 'screens/signup_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(const ALUConnectApp());
}

class ALUConnectApp extends StatelessWidget {
  const ALUConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, child) => MaterialApp(
        title: 'ALU Connect',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: mode,
        home: const AuthGate(),
        routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        AluSignInScreen.routeName: (_) => const AluSignInScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
        MainTabScreen.routeName: (_) => const MainTabScreen(),
        CreatePostScreen.routeName: (_) => const CreatePostScreen(),
        EventDetailScreen.routeName: (_) => const EventDetailScreen(),
        ChatDetailScreen.routeName: (_) => const ChatDetailScreen(),
        CommunitiesScreen.routeName: (_) => const CommunitiesScreen(),
        EventsScreen.routeName: (_) => const EventsScreen(),
        OpportunitiesScreen.routeName: (_) => const OpportunitiesScreen(),
        JobsScreen.routeName: (_) => const JobsScreen(),
        MentorsScreen.routeName: (_) => const MentorsScreen(),
        ResourcesScreen.routeName: (_) => const ResourcesScreen(),
        NotificationsScreen.routeName: (_) => const NotificationsScreen(),
      },
    ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final col = AppColors.of(context);
    return FutureBuilder<bool>(
      future: AuthService.isSignedIn(),
      builder: (_, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator(color: col.accent)),
          );
        }
        if (snapshot.data == true) return const MainTabScreen();
        return const LoginScreen();
      },
    );
  }
}
