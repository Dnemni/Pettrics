import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ActivityChip extends StatelessWidget {
  final String label;
  final bool selected;
  final IconData? icon;
  final VoidCallback? onTap;

  const ActivityChip({
    super.key,
    required this.label,
    this.selected = false,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = selected
        ? theme.colorScheme.primary
        : isDark
            ? Colors.white.withOpacity(0.08)
            : Colors.white.withOpacity(0.9);

    final textColor = selected
        ? Colors.black
        : isDark
            ? Colors.white
            : Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: icon != null ? 12 : 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: selected && !isDark
              ? Border.all(color: theme.colorScheme.primary, width: 1.5)
              : null,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: textColor),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: textColor,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                fontSize: 14,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
