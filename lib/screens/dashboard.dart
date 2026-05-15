import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sg/screens/auth/signin_screen.dart';
import 'package:sg/screens/tasks/completed_tasks_screen.dart';
import 'package:sg/screens/tasks/ongoing_tasks_screen.dart';
import 'package:sg/screens/tasks/pending_tasks_screen.dart';
import 'package:sg/widgets/tasks/add_task_bottom_sheet.dart';
import 'package:sg/widgets/quote/quote.dart';
import '../widgets/navigation/bottom_nav_bar.dart';
import '../providers/navigation_provider.dart';

import '../utils/app_theme.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn.instance.disconnect();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignInScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);
    final theme = ref.watch(themeProvider);

    final List<Widget> screens = [
      const PendingTasksScreen(),
      const OngoingTasksScreen(),
      const CompletedTasksScreen(),
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: SizedBox(
        height: 75,
        width: 75,
        child: FloatingActionButton(
          backgroundColor: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          ),

          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddTaskBottomSheet(),
            );
          },
          child: const Icon(Icons.add, color: Colors.white,),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: theme.appBarTitleStyle,
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.appBarTextColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const QuoteWidget(),
            const SizedBox(height: 30,),
            Expanded(child: screens[currentIndex]),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
