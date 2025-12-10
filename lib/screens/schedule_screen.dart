import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../theme/app_theme.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _displayedMonth = DateTime.now();
  int _viewMode = 2; // 0=Day, 1=Week, 2=Month

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.8, -0.9),
              radius: 1.4,
              colors: [
                AppColors.primary.withOpacity(isDark ? 0.08 : 0.05),
                Colors.transparent,
              ],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context, isDark),
                const SizedBox(height: 16),
                _buildViewModeSelector(isDark),
                const SizedBox(height: 16),
                if (_viewMode == 2) ...[
                  _buildCalendar(context, isDark),
                  const SizedBox(height: 20),
                ] else if (_viewMode == 1) ...[
                  _buildWeekScroller(context, isDark),
                  const SizedBox(height: 20),
                ] else ...[
                  _buildDayNavigator(context, isDark),
                  const SizedBox(height: 20),
                ],
                Expanded(
                  child: _buildScheduleList(context, isDark),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 100,
          child: Container(
            width: 60,
            height: 60,
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
              onPressed: () => HapticFeedback.mediumImpact(),
              elevation: 0,
              child: const Icon(CupertinoIcons.add, size: 28),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
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
                CupertinoIcons.chevron_left,
                color: isDark ? Colors.white : Colors.black87,
              ),
              onPressed: () => HapticFeedback.lightImpact(),
            ),
          ),
          const Spacer(),
          Text(
            'Schedules & Reminders',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildViewModeSelector(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _ModeButton(
            label: 'Day',
            selected: _viewMode == 0,
            onTap: () => setState(() => _viewMode = 0),
            isDark: isDark,
          ),
          const SizedBox(width: 10),
          _ModeButton(
            label: 'Week',
            selected: _viewMode == 1,
            onTap: () => setState(() => _viewMode = 1),
            isDark: isDark,
          ),
          const SizedBox(width: 10),
          _ModeButton(
            label: 'Month',
            selected: _viewMode == 2,
            onTap: () => setState(() => _viewMode = 2),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? Theme.of(context).cardColor.withOpacity(0.6)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.05),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildMonthHeader(isDark),
            const SizedBox(height: 20),
            _buildWeekdayLabels(isDark),
            const SizedBox(height: 12),
            _buildCalendarGrid(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthHeader(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          DateFormat('MMMM yyyy').format(_displayedMonth),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                CupertinoIcons.chevron_left,
                color: isDark ? Colors.white70 : Colors.black54,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _displayedMonth = DateTime(
                    _displayedMonth.year,
                    _displayedMonth.month - 1,
                  );
                });
              },
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.chevron_right,
                color: isDark ? Colors.white70 : Colors.black54,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _displayedMonth = DateTime(
                    _displayedMonth.year,
                    _displayedMonth.month + 1,
                  );
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeekdayLabels(bool isDark) {
    const weekdays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekdays
          .map((day) => SizedBox(
                width: 36,
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: isDark
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.4),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid(bool isDark) {
    final firstDayOfMonth =
        DateTime(_displayedMonth.year, _displayedMonth.month, 1);
    final lastDayOfMonth =
        DateTime(_displayedMonth.year, _displayedMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final startWeekday = firstDayOfMonth.weekday % 7;

    final days = <Widget>[];

    // Add empty spaces for days before the first of the month
    for (var i = 0; i < startWeekday; i++) {
      days.add(const SizedBox(width: 36, height: 36));
    }

    // Add actual days
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_displayedMonth.year, _displayedMonth.month, day);
      final isSelected = _selectedDate.year == date.year &&
          _selectedDate.month == date.month &&
          _selectedDate.day == date.day;
      final isToday = DateTime.now().year == date.year &&
          DateTime.now().month == date.month &&
          DateTime.now().day == date.day;
      final hasEvent = [4, 12, 24, 25, 27].contains(day);

      days.add(_CalendarDay(
        day: day,
        isSelected: isSelected,
        isToday: isToday,
        hasEvent: hasEvent,
        isDark: isDark,
        onTap: () {
          HapticFeedback.selectionClick();
          setState(() {
            _selectedDate = date;
          });
        },
      ));
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: days,
    );
  }

  Widget _buildWeekScroller(BuildContext context, bool isDark) {
    final startOfWeek = _selectedDate.subtract(
      Duration(days: _selectedDate.weekday % 7),
    );
    final weekDays = List.generate(6, (i) => startOfWeek.add(Duration(days: i)));

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final date = weekDays[index];
          final isSelected = _selectedDate.year == date.year &&
              _selectedDate.month == date.month &&
              _selectedDate.day == date.day;
          return _WeekDayPill(
            date: date,
            selected: isSelected,
            isDark: isDark,
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _selectedDate = date);
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemCount: weekDays.length,
      ),
    );
  }

  Widget _buildDayNavigator(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              CupertinoIcons.chevron_left,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
          ),
          Text(
            DateFormat('EEEE, MMMM d').format(_selectedDate),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
          ),
          IconButton(
            icon: Icon(
              CupertinoIcons.chevron_right,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleList(BuildContext context, bool isDark) {
    final isToday = _selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            isToday
                ? 'Today, ${DateFormat('MMMM d').format(_selectedDate)}'
                : DateFormat('EEEE, MMMM d').format(_selectedDate),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
            physics: const BouncingScrollPhysics(),
            children: [
              _TimelineItem(
                icon: CupertinoIcons.square_favorites_alt,
                iconColor: AppColors.meal,
                title: 'Morning Meal',
                time: '7:00 AM',
                completed: true,
                isDark: isDark,
                showLine: true,
              ),
              _TimelineItem(
                icon: CupertinoIcons.paw,
                iconColor: AppColors.walk,
                title: 'Walk',
                time: '8:00 AM',
                completed: false,
                isDark: isDark,
                showLine: true,
              ),
              _TimelineItem(
                icon: CupertinoIcons.capsule,
                iconColor: AppColors.medication,
                title: 'Medication',
                time: '12:00 PM',
                completed: false,
                isDark: isDark,
                showLine: true,
              ),
              _TimelineItem(
                icon: CupertinoIcons.square_favorites_alt,
                iconColor: AppColors.meal,
                title: 'Evening Meal',
                time: '6:00 PM',
                completed: false,
                isDark: isDark,
                showLine: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class _CalendarDay extends StatelessWidget {
  final int day;
  final bool isSelected;
  final bool isToday;
  final bool hasEvent;
  final bool isDark;
  final VoidCallback onTap;

  const _CalendarDay({
    required this.day,
    required this.isSelected,
    required this.isToday,
    required this.hasEvent,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.transparent,
          shape: BoxShape.circle,
          border: isToday && !isSelected
              ? Border.all(
                  color: AppColors.primary,
                  width: 2,
                )
              : null,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              day.toString(),
              style: TextStyle(
                color: isSelected
                    ? Colors.black
                    : (isDark ? Colors.white : Colors.black87),
                fontWeight: isSelected || isToday
                    ? FontWeight.w700
                    : FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (hasEvent && !isSelected)
              Positioned(
                bottom: 4,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: hasEvent
                        ? (day == 4 || day == 25
                            ? AppColors.primary
                            : AppColors.warning)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WeekDayPill extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _WeekDayPill({
    required this.date,
    required this.selected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : (isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.04)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: TextStyle(
                color: selected
                    ? Colors.black
                    : (isDark
                        ? Colors.white.withOpacity(0.6)
                        : Colors.black.withOpacity(0.5)),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date.day.toString(),
              style: TextStyle(
                color: selected
                    ? Colors.black
                    : (isDark ? Colors.white : Colors.black87),
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String time;
  final bool completed;
  final bool isDark;
  final bool showLine;

  const _TimelineItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.completed,
    required this.isDark,
    required this.showLine,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(icon, color: iconColor, size: 24),
                    if (completed)
                      Positioned(
                        right: 2,
                        top: 2,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? AppColors.backgroundDark
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.checkmark,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (showLine)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.08),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => HapticFeedback.lightImpact(),
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark
                      ? Theme.of(context).cardColor.withOpacity(0.6)
                      : Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  decoration: completed
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: completed
                                      ? (isDark
                                          ? Colors.white.withOpacity(0.5)
                                          : Colors.black.withOpacity(0.4))
                                      : null,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            time,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.black.withOpacity(0.4),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: completed
                              ? AppColors.success
                              : (isDark
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.black.withOpacity(0.15)),
                          width: 2,
                        ),
                        color: completed
                            ? AppColors.success
                            : Colors.transparent,
                      ),
                      child: completed
                          ? const Icon(
                              CupertinoIcons.checkmark,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool isDark;

  const _ModeButton({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : (isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.04)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : (isDark ? Colors.white : Colors.black87),
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
