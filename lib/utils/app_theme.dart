import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppTheme {
  // Colors
  final Color primaryColor = Colors.deepPurple;
  final Color redColor = const Color(0xFFB73B3D);
  final Color blueColor = const Color(0xFF008FAB);
  final Color greenColor = const Color(0xFF20BE00);
  final Color white = Colors.white;
  final Color black = Colors.black;

  final Color scaffoldBackgroundColor = const Color(0xFFFAFAFA); // Colors.grey[50]
  final Color backgroundColor = const Color(0xFFE7E7E7);
  final Color appBarTextColor = Colors.white;
  final Color unselectedItemColor = Colors.grey;


  // Typography
  final TextStyle screenTitleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  final TextStyle appBarTitleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );
}

// Riverpod Provider for Theme
final themeProvider = Provider<AppTheme>((ref) {
  return AppTheme();
});
