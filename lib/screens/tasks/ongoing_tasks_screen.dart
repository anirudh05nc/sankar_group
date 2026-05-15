import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/app_theme.dart';
import '../../widgets/tasks/task_card/ongoing_task_card.dart';
import '../../providers/tasks_provider.dart';
import '../../widgets/tasks/task_popup_cards/ongoing_task_popup.dart';
import '../../widgets/tasks/edit_task_bottom_sheet.dart';

class OngoingTasksScreen extends ConsumerWidget {
  const OngoingTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final tasksAsync = ref.watch(userTasksProvider);

    return tasksAsync.when(
      data: (tasks) {
        final ongoingTasks = tasks.where((t) => t.status == 'ongoing').toList();
        if (ongoingTasks.isEmpty) {
          return Center(
            child: Text(
              'no tasks are found',
              style: TextStyle(color: theme.primaryColor, fontSize: 18),
            ),
          );
        }
        return ListView.separated(
          itemCount: ongoingTasks.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final task = ongoingTasks[index];
            return OngoingTaskCard(
              title: task.title,
              description: task.description,
              date: task.deadline,
              daysLeft: task.deadline,
              onMenuTap: () async {
                final action = await showDialog<String>(
                  context: context,
                  builder: (context) => OngoingTaskPopup(
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
