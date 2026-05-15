import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tasks_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/tasks/task_card/completed_task_card.dart';
import '../../widgets/tasks/task_popup_cards/completed_task_popup.dart';
import '../../widgets/tasks/edit_task_bottom_sheet.dart';

class CompletedTasksScreen extends ConsumerWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final tasksAsync = ref.watch(userTasksProvider);

    return tasksAsync.when(
      data: (tasks) {
        final completedTasks = tasks.where((t) => t.status.startsWith('completed')).toList();
        if (completedTasks.isEmpty) {
          return Center(
            child: Text(
              'no tasks are found',
              style: TextStyle(color: theme.primaryColor, fontSize: 18),
            ),
          );
        }
        return ListView.separated(
          itemCount: completedTasks.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final task = completedTasks[index];
            return CompletedTaskCard(
              title: task.title,
              description: task.description,
              date: task.deadline,
              daysLeft: task.deadline,
              onMenuTap: () async {
                final action = await showDialog<String>(
                  context: context,
                  builder: (context) => CompletedTaskPopup(
                    task: task,
                    daysLeft: task.deadline,
                  ),
                );
                if (action == 'edit' && context.mounted) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => EditTaskBottomSheet(task: task),
                  );
                }
              },
            );
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator(color: theme.primaryColor)),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
