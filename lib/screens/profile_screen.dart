import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/pet_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, isDark),
                  const SizedBox(height: 28),
                  _buildPetInfo(context, isDark),
                  const SizedBox(height: 24),
                  _buildQuickStats(context, isDark),
                  const SizedBox(height: 28),
                  _buildGeneralInfo(context, isDark),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Health Records'),
                  _buildHealthRecords(context, isDark),
                  const SizedBox(height: 20),
                  _buildSectionTitle(context, 'Health Goals'),
                  _buildHealthGoals(context, isDark),
                  const SizedBox(height: 24),
                  _buildNotificationToggle(context, isDark),
                  const SizedBox(height: 24),
                  _buildShareButton(context),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Row(
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
          'Profile',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const Spacer(),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => HapticFeedback.lightImpact(),
          child: Text(
            'Edit',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildPetInfo(BuildContext context, bool isDark) {
    return Center(
      child: Column(
        children: [
          const PetAvatar(
            imageUrl:
                'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400',
            size: 120,
          ),
          const SizedBox(height: 16),
          Text(
            'Milo',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            'Golden Retriever, 5 yrs',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _StatPill(
            label: 'Weight',
            value: '75 lbs',
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatPill(
            label: 'Activity',
            value: '85%',
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatPill(
            label: 'Intake',
            value: '900 kcal',
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _buildGeneralInfo(BuildContext context, bool isDark) {
    return _buildListTile(
      context,
      icon: CupertinoIcons.info_circle,
      color: AppColors.info,
      title: 'General Information',
      subtitle: 'Microchip, Owner Info, Status',
      isDark: isDark,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  Widget _buildHealthRecords(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildListTile(
          context,
          icon: CupertinoIcons.bandage_fill,
          color: Colors.redAccent,
          title: 'Vaccinations',
          subtitle: 'Rabies, DHPP, Bordetella',
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _buildListTile(
          context,
          icon: CupertinoIcons.bandage,
          color: Colors.orangeAccent,
          title: 'Allergies',
          subtitle: 'Pollen, Chicken',
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _buildListTile(
          context,
          icon: CupertinoIcons.plus_circle,
          color: AppColors.vet,
          title: 'Vet Visits',
          subtitle: 'Annual Checkup: Mar 2024',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildHealthGoals(BuildContext context, bool isDark) {
    return Column(
      children: [
        _buildListTile(
          context,
          icon: CupertinoIcons.chart_bar_alt_fill,
          color: AppColors.primary,
          title: 'Weight Management',
          subtitle: 'Target: 72 lbs',
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _buildListTile(
          context,
          icon: CupertinoIcons.flame,
          color: AppColors.primary,
          title: 'Activity Goal',
          subtitle: 'Daily Target: 100%',
          isDark: isDark,
        ),
        const SizedBox(height: 10),
        _buildListTile(
          context,
          icon: CupertinoIcons.capsule,
          color: AppColors.medication,
          title: 'Medications & Reminders',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildNotificationToggle(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.black.withOpacity(0.05),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.info.withOpacity(0.15),
            ),
            child: const Icon(
              CupertinoIcons.bell,
              color: AppColors.info,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              'Notification Preferences',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          CupertinoSwitch(
            value: true,
            activeTrackColor: AppColors.primary,
            onChanged: (value) => HapticFeedback.lightImpact(),
          ),
        ],
      ),
    );
  }

  Widget _buildShareButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: CupertinoButton(
        onPressed: () => HapticFeedback.mediumImpact(),
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        padding: EdgeInsets.zero,
        child: const Text(
          'Share Records',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 17,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    String? subtitle,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () => HapticFeedback.selectionClick(),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color.withOpacity(0.15),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.white60 : Colors.black54,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              color: isDark ? Colors.white.withOpacity(0.4) : Colors.black26,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _StatPill({
    required this.label,
    required this.value,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
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
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
          ),
        ],
      ),
    );
  }
}
