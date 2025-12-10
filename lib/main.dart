import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/insights_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set iOS-style system UI overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
    ),
  );

  runApp(const PettricsApp());
}

class PettricsApp extends StatelessWidget {
  const PettricsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pettrics',
      themeMode: ThemeMode.system,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const PettricsHome(),
    );
  }
}

class PettricsHome extends StatefulWidget {
  const PettricsHome({super.key});

  @override
  State<PettricsHome> createState() => _PettricsHomeState();
}

class _PettricsHomeState extends State<PettricsHome>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    HapticFeedback.lightImpact();

    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onAddPressed() {
    HapticFeedback.mediumImpact();
    _showAddActivitySheet();
  }

  void _showAddActivitySheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddActivitySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          HapticFeedback.selectionClick();
          setState(() => _currentIndex = index);
        },
        physics: const BouncingScrollPhysics(),
        children: const [
          HomeDashboardScreen(),
          ScheduleScreen(),
          InsightsScreen(),
          ProfileScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _onAddPressed,
          elevation: 0,
          child: const Icon(CupertinoIcons.add, size: 32),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.backgroundDarkAlt.withOpacity(0.95)
              : AppColors.backgroundLightAlt.withOpacity(0.95),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.08),
              width: 0.5,
            ),
          ),
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              notchMargin: 8,
              shape: const CircularNotchedRectangle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: CupertinoIcons.square_list,
                      activeIcon: CupertinoIcons.square_list_fill,
                      label: 'Log',
                      selected: _currentIndex == 0,
                      onTap: () => _onTabSelected(0),
                    ),
                    _NavItem(
                      icon: CupertinoIcons.calendar,
                      activeIcon: CupertinoIcons.calendar_today,
                      label: 'Schedule',
                      selected: _currentIndex == 1,
                      onTap: () => _onTabSelected(1),
                    ),
                    const SizedBox(width: 64), // FAB space
                    _NavItem(
                      icon: CupertinoIcons.chart_bar,
                      activeIcon: CupertinoIcons.chart_bar_fill,
                      label: 'Insights',
                      selected: _currentIndex == 2,
                      onTap: () => _onTabSelected(2),
                    ),
                    _NavItem(
                      icon: CupertinoIcons.person,
                      activeIcon: CupertinoIcons.person_fill,
                      label: 'Profile',
                      selected: _currentIndex == 3,
                      onTap: () => _onTabSelected(3),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final color = selected
        ? AppColors.primary
        : isDark
            ? Colors.white60
            : Colors.black45;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: AppColors.primary.withOpacity(0.1),
        highlightColor: AppColors.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                selected ? activeIcon : icon,
                size: 22,
                color: color,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 10,
                  letterSpacing: 0,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddActivitySheet extends StatelessWidget {
  const AddActivitySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : AppColors.cardLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(
        24,
        12,
        24,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 5,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black26,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Log Activity',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ActivityButton(
                icon: CupertinoIcons.square_favorites_alt,
                label: 'Meal',
                color: AppColors.meal,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                },
              ),
              _ActivityButton(
                icon: CupertinoIcons.paw,
                label: 'Walk',
                color: AppColors.walk,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                },
              ),
              _ActivityButton(
                icon: CupertinoIcons.circle_fill,
                label: 'Treat',
                color: AppColors.treat,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                },
              ),
              _ActivityButton(
                icon: CupertinoIcons.capsule,
                label: 'Medicine',
                color: AppColors.medication,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                },
              ),
              _ActivityButton(
                icon: CupertinoIcons.bandage,
                label: 'Vet Visit',
                color: AppColors.vet,
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActivityButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActivityButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
