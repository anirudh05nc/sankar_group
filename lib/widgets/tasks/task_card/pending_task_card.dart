import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/app_theme.dart';

class PendingTaskCard extends ConsumerWidget {
  final String title;
  final String description;
  final String date;
  final String daysLeft;
  final VoidCallback? onMenuTap;

  const PendingTaskCard({
    super.key,
    this.title = 'Title of the Task',
    this.description = 'Description of the Task Explaining about the task in detail and some information about the task',
    this.date = '00/00/0000',
    this.daysLeft = 'XX Days Left',
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: theme.white,
        border: Border.all(color: theme.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onMenuTap,
                child: Icon(Icons.more_horiz, color: theme.primaryColor, size: 28),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Date : $date',
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: theme.redColor, width: 1.5),
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
                    text: 'Pending ($daysLeft)',
                    style: TextStyle(color: theme.redColor, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
