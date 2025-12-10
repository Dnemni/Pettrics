import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ScheduleItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String time;
  final bool dimmed;
  final bool completed;
  final VoidCallback? onTap;

  const ScheduleItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
    this.dimmed = false,
    this.completed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor =
        isDark ? theme.cardColor.withOpacity(0.6) : theme.cardColor;

    final textColor = dimmed
        ? (isDark
            ? Colors.white.withOpacity(0.35)
            : Colors.black.withOpacity(0.35))
        : (isDark ? Colors.white : Colors.black87);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.05),
            width: 1,
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColor.withOpacity(dimmed ? 0.12 : 0.18),
                borderRadius: BorderRadius.circular(14),
              ),
              height: 44,
              width: 44,
              child: Icon(
                icon,
                color: iconColor.withOpacity(dimmed ? 0.5 : 1.0),
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: textColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            if (completed)
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: theme.colorScheme.primary,
                size: 26,
              )
            else
              Icon(
                CupertinoIcons.circle,
                color: isDark
                    ? Colors.white.withOpacity(0.25)
                    : Colors.black.withOpacity(0.15),
                size: 26,
              ),
          ],
        ),
      ),
    );
  }
}
