import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUser {
  final String name;
  final String email;
  final String password;
  final String role;

  const AuthUser({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });
}

class AuthService {
  AuthService._();

  static const _tokenKey = 'auth_token';
  static const _userNameKey = 'user_name';
  static const _userEmailKey = 'user_email';
  static const _userRoleKey = 'user_role';
  static final _secure = FlutterSecureStorage();

  static final List<AuthUser> _mockUsers = [
    const AuthUser(
      name: 'Aline Umuhoza',
      email: 'aline@alu.edu',
      password: 'password123',
      role: 'Club Leader',
    ),
    const AuthUser(
      name: 'Brian Mensah',
      email: 'brian@alu.edu',
      password: 'startup2026',
      role: 'Entrepreneur',
    ),
    const AuthUser(
      name: 'Chloe Kim',
      email: 'chloe@alu.edu',
      password: 'hackathon',
      role: 'Event Organizer',
    ),
    const AuthUser(
      name: 'Diana Ade',
      email: 'diana@alu.edu',
      password: 'community',
      role: 'Student Community',
    ),
    const AuthUser(
      name: 'Emmanuel N.',
      email: 'emmanuel@alu.edu',
      password: 'academic',
      role: 'Academic Team',
    ),
    const AuthUser(
      name: 'Fiona Okonkwo',
      email: 'fiona@alu.edu',
      password: 'member123',
      role: 'Member',
    ),
  ];

  static const Set<String> _authorizedRoles = {
    'Club Leader',
    'Event Organizer',
    'Entrepreneur',
    'Student Community',
    'Academic Team',
  };

  static Future<bool> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    AuthUser? user;
    for (final u in _mockUsers) {
      if (u.email == email && u.password == password) {
        user = u;
        break;
      }
    }

    if (user == null) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, user.email);
    await prefs.setString(_userNameKey, user.name);
    await prefs.setString(_userRoleKey, user.role);
    await _secure.write(key: _tokenKey, value: 'token_${DateTime.now().millisecondsSinceEpoch}');
    return true;
  }

  static Future<bool> register(String name, String email, String password, String role) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    if (name.isEmpty || email.isEmpty || password.isEmpty || role.isEmpty) {
      return false;
    }

    for (final u in _mockUsers) {
      if (u.email == email) {
        return false;
      }
    }

    final newUser = AuthUser(name: name, email: email, password: password, role: role);
    _mockUsers.add(newUser);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, newUser.email);
    await prefs.setString(_userNameKey, newUser.name);
    await prefs.setString(_userRoleKey, newUser.role);
    await _secure.write(key: _tokenKey, value: 'token_${DateTime.now().millisecondsSinceEpoch}');
    return true;
  }

  static Future<void> signOut() async {
    await _secure.delete(key: _tokenKey);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userRoleKey);
  }

  static Future<bool> isSignedIn() async {
    final token = await _secure.read(key: _tokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<String?> currentUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey);
  }

  static Future<String?> currentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  static Future<String?> currentUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userRoleKey);
  }

  static Future<bool> canPost() async {
    final role = await currentUserRole();
    return role != null && _authorizedRoles.contains(role);
  }
}
