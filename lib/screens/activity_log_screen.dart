import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/activity_chip.dart';

class ActivityLogScreen extends StatefulWidget {
  const ActivityLogScreen({super.key});

  @override
  State<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends State<ActivityLogScreen> {
  int _selectedDay = 1; // 0=Yesterday, 1=Today, 2=Tomorrow

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.6, -0.8),
          radius: 1.3,
          colors: [
            AppColors.primary.withOpacity(isDark ? 0.15 : 0.12),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(context, isDark),
            const SizedBox(height: 12),
            _buildDayChips(),
            const SizedBox(height: 20),
            _buildLogActivitySection(context),
            const SizedBox(height: 24),
            Expanded(child: _buildTodayLog(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: isDark ? Colors.white : Colors.black87,
              ),
              onPressed: () => HapticFeedback.lightImpact(),
            ),
          ),
          const Spacer(),
          Text(
            'Activity Log',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const Spacer(),
          const PetAvatarSmall(),
        ],
      ),
    );
  }

  Widget _buildDayChips() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          ActivityChip(
            label: 'Yesterday',
            selected: _selectedDay == 0,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedDay = 0);
            },
          ),
          const SizedBox(width: 10),
          ActivityChip(
            label: 'Today',
            selected: _selectedDay == 1,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedDay = 1);
            },
          ),
          const SizedBox(width: 10),
          ActivityChip(
            label: 'Tomorrow',
            selected: _selectedDay == 2,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedDay = 2);
            },
          ),
          const SizedBox(width: 10),
          ActivityChip(
            label: 'Calendar',
            icon: CupertinoIcons.calendar,
            onTap: () => HapticFeedback.lightImpact(),
          ),
        ],
      ),
    );
  }

  Widget _buildLogActivitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Log an Activity',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ActivityType(
                icon: CupertinoIcons.square_favorites_alt,
                label: 'Meal',
                color: AppColors.meal,
              ),
              _ActivityType(
                icon: CupertinoIcons.paw,
                label: 'Walk',
                color: AppColors.walk,
              ),
              _ActivityType(
                icon: CupertinoIcons.circle_fill,
                label: 'Treat',
                color: AppColors.treat,
              ),
              _ActivityType(
                icon: CupertinoIcons.capsule,
                label: 'Meds',
                color: AppColors.medication,
              ),
              _ActivityType(
                icon: CupertinoIcons.bandage,
                label: 'Vet',
                color: AppColors.vet,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayLog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Log",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: const [
                _LogCard(
                  color: AppColors.walk,
                  icon: CupertinoIcons.paw,
                  title: 'Evening Walk',
                  subtitle: '6:30 PM',
                  trailingTop: '1.2 miles',
                  trailingBottom: '25 min',
                ),
                SizedBox(height: 12),
                _LogCard(
                  color: AppColors.medication,
                  icon: CupertinoIcons.capsule,
                  title: 'Allergy Medication',
                  subtitle: '8:35 AM',
                  trailingTop: '1 tablet',
                ),
                SizedBox(height: 12),
                _LogCard(
                  color: AppColors.meal,
                  icon: CupertinoIcons.square_favorites_alt,
                  title: 'Breakfast',
                  subtitle: '8:30 AM',
                  trailingTop: 'Kibble',
                  trailingBottom: '1.5 cups',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityType extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActivityType({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => HapticFeedback.mediumImpact(),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _LogCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final String trailingTop;
  final String? trailingBottom;

  const _LogCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailingTop,
    this.trailingBottom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor =
        isDark ? theme.cardColor.withOpacity(0.6) : theme.cardColor;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
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
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
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
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                trailingTop,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (trailingBottom != null) ...[
                const SizedBox(height: 4),
                Text(
                  trailingBottom!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class PetAvatarSmall extends StatelessWidget {
  const PetAvatarSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Image.network(
          'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.primary.withOpacity(0.2),
              child: const Icon(
                CupertinoIcons.paw,
                size: 20,
                color: AppColors.primary,
              ),
            );
          },
        ),
      ),
    );
  }
}
