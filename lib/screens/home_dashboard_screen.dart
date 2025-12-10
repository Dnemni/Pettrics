import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/pet_avatar.dart';
import '../widgets/stat_card.dart';
import '../widgets/schedule_item.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(-0.8, -0.9),
          radius: 1.4,
          colors: [
            AppColors.primary.withOpacity(isDark ? 0.12 : 0.08),
            Colors.transparent,
          ],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, isDark),
                    const SizedBox(height: 28),
                    _buildStatCards(context),
                    const SizedBox(height: 32),
                    _buildUpcomingSchedule(context),
                    const SizedBox(height: 32),
                    _buildHealthInsights(context),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return FadeTransition(
      opacity: _animationController,
      child: Row(
        children: [
          const PetAvatar(
            imageUrl:
                'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400',
            size: 64,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Max',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Golden Retriever, 2 yrs',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark ? Colors.white60 : Colors.black54,
                      ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.bell,
                color: isDark ? Colors.white : Colors.black87,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
              },
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.gear_alt,
                color: isDark ? Colors.white : Colors.black87,
              ),
              onPressed: () {
                HapticFeedback.lightImpact();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.2, 1.0),
        ),
        child: const Row(
          children: [
            Expanded(
              child: StatCard(
                icon: CupertinoIcons.square_favorites_alt,
                iconColor: AppColors.primary,
                title: 'Diet',
                value: '2/3',
                subtitle: 'Meals Eaten',
                progress: 2 / 3,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: StatCard(
                icon: CupertinoIcons.paw,
                iconColor: AppColors.primary,
                title: 'Exercise',
                value: '45/60 min',
                subtitle: 'Activity Goal',
                progress: 0.75,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingSchedule(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.4, 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upcoming Schedule',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 14),
            ScheduleItem(
              icon: CupertinoIcons.paw,
              iconColor: AppColors.primary,
              title: 'Evening Walk',
              time: '5:00 PM',
              onTap: () => HapticFeedback.selectionClick(),
            ),
            const SizedBox(height: 12),
            ScheduleItem(
              icon: CupertinoIcons.capsule,
              iconColor: AppColors.medication,
              title: 'Flea Medication',
              time: '7:00 PM',
              onTap: () => HapticFeedback.selectionClick(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthInsights(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.2),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.6, 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Insights',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Theme.of(context).cardColor.withOpacity(0.6)
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: primary.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primary.withOpacity(0.1),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'INSIGHT OF THE DAY',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: primary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Max's sleep was 15% deeper last night after his evening walk. Consider a slightly longer walk today for even better rest!",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => HapticFeedback.lightImpact(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Learn More',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(width: 4),
                        Icon(CupertinoIcons.chevron_right,
                            size: 18, color: primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
