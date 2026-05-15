import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/task_model.dart';
import '../../../providers/tasks_provider.dart';
import '../../../utils/app_theme.dart';

class OngoingTaskPopup extends ConsumerWidget {
  final TaskModel task;
  final String daysLeft;

  const OngoingTaskPopup({
    super.key,
    required this.task,
    required this.daysLeft,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.primaryColor, width: 3),
      ),
      backgroundColor: theme.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              task.description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Date : ${task.deadline}',
              style: TextStyle(
                color: theme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: theme.blueColor, width: 1.5),
                borderRadius: BorderRadius.circular(6),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Status : ',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    TextSpan(
                      text: 'OnGoing ($daysLeft)',
                      style: TextStyle(color: theme.blueColor, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: theme.primaryColor, width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildActionIcon(
                    icon: Icons.delete,
                    color: Colors.grey,
                    label: 'Delete',
                    onTap: () async {
                      await ref.read(firestoreServiceProvider).deleteTask(task.id);
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                  _buildActionIcon(
                    icon: Icons.edit_square,
                    color: theme.primaryColor,
                    label: 'Edit',
                    onTap: () {
                      Navigator.pop(context, 'edit');
                    },
                  ),
                  _buildActionIcon(
                    icon: Icons.pending_actions,
                    color: theme.redColor,
                    label: 'Move to\nPending',
                    onTap: () async {
                      await ref.read(firestoreServiceProvider).updateTaskStatus(task.id, 'pending');
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                  _buildActionIcon(
                    icon: Icons.check_circle_outline,
                    color: theme.greenColor,
                    label: 'Move to\nCompleted',
                    onTap: () async {
                      await ref.read(firestoreServiceProvider).updateTaskStatus(task.id, 'completed');
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
