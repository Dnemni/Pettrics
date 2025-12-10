import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
                    const SizedBox(height: 20),
                    Text(
                      'Insights',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 20),
                    _buildHeroCard(context, isDark),
                    const SizedBox(height: 28),
                    _buildSuggestions(context, isDark),
                    const SizedBox(height: 28),
                    _buildTrends(context, isDark),
                    const SizedBox(height: 28),
                    _buildNeedsAttention(context, isDark),
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
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
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
            ),
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.04),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () => HapticFeedback.lightImpact(),
            icon: Icon(
              CupertinoIcons.plus_circle,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primary.withOpacity(0.12)
            : AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const NetworkImage(
                  'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?w=800',
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Great Job! Buddy's daily walk average is up 40% this month.",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Keep up the consistent walk schedule to maintain this positive trend.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.6),
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personalized Suggestions',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 14),
        _SuggestionCard(
          icon: CupertinoIcons.flame,
          title: 'New Exercise Goal',
          description:
              'Buddy is ready for a challenge. Try a 30-minute fetch session at the park this weekend.',
          cta: 'Add to Schedule',
          isDark: isDark,
        ),
        const SizedBox(height: 12),
        _SuggestionCard(
          icon: CupertinoIcons.square_favorites_alt,
          title: 'Healthy Treat Option',
          description:
              'Consider adding blueberries as a low-calorie, antioxidant-rich snack to Buddy\'s diet.',
          cta: 'Learn More',
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildTrends(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health Trends',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 14),
        _TrendCard(
          title: 'Activity',
          value: '5,280 Steps',
          subtitle: 'Last 30 days',
          delta: '+10%',
          isPositive: true,
          isDark: isDark,
          chartData: [0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.9],
        ),
        const SizedBox(height: 12),
        _TrendCard(
          title: 'Nutrition',
          value: '2,100 kcal',
          subtitle: 'Last 30 days',
          delta: '+2%',
          isPositive: true,
          isDark: isDark,
          chartData: [0.6, 0.7, 0.5, 0.6, 0.8, 0.7, 0.75],
        ),
        const SizedBox(height: 12),
        _TrendCard(
          title: 'Sleep',
          value: '8h 15m',
          subtitle: 'Last 30 days',
          delta: '-3%',
          isPositive: false,
          isDark: isDark,
          chartData: [0.7, 0.8, 0.9, 0.7, 0.85, 0.6, 0.65],
        ),
      ],
    );
  }

  Widget _buildNeedsAttention(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Needs Attention',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 14),
        _AttentionRow(
          icon: CupertinoIcons.exclamationmark_triangle,
          iconColor: AppColors.warning,
          text: 'Missed 2 meals this week',
          isDark: isDark,
        ),
        _AttentionRow(
          icon: CupertinoIcons.bandage,
          iconColor: AppColors.info,
          text: 'Annual vaccination due soon',
          isDark: isDark,
        ),
      ],
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String cta;
  final bool isDark;

  const _SuggestionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.cta,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.12)
              : Colors.black.withOpacity(0.06),
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
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark ? Colors.white70 : Colors.black54,
                            height: 1.4,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: () => HapticFeedback.lightImpact(),
              padding: const EdgeInsets.symmetric(vertical: 12),
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              child: Text(
                cta,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final String delta;
  final bool isPositive;
  final bool isDark;
  final List<double> chartData;

  const _TrendCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.delta,
    required this.isPositive,
    required this.isDark,
    required this.chartData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? Colors.white.withOpacity(0.7)
                          : Colors.black.withOpacity(0.6),
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.success : AppColors.error)
                      .withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  delta,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isPositive ? AppColors.success : AppColors.error,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
          ),
          const SizedBox(height: 16),
          _MiniLineChart(
            data: chartData,
            color: AppColors.primary,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _MiniLineChart extends StatelessWidget {
  final List<double> data;
  final Color color;
  final bool isDark;

  const _MiniLineChart({
    required this.data,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: CustomPaint(
        painter: _LineChartPainter(
          data: data,
          color: color,
          isDark: isDark,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color color;
  final bool isDark;

  _LineChartPainter({
    required this.data,
    required this.color,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withOpacity(0.3),
          color.withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();
    final segmentWidth = size.width / (data.length - 1);

    // Start paths
    final firstY = size.height - (data[0] * size.height);
    path.moveTo(0, firstY);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, firstY);

    // Draw line and fill
    for (int i = 0; i < data.length; i++) {
      final x = i * segmentWidth;
      final y = size.height - (data[i] * size.height);

      if (i == 0) continue;

      path.lineTo(x, y);
      fillPath.lineTo(x, y);
    }

    // Complete fill path
    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    // Draw fill then line
    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);

    // Draw dots
    for (int i = 0; i < data.length; i++) {
      final x = i * segmentWidth;
      final y = size.height - (data[i] * size.height);

      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawCircle(Offset(x, y), 3, dotPaint);

      final ringPaint = Paint()
        ..color = isDark ? const Color(0xFF0A140E) : Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(x, y), 3, ringPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AttentionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final bool isDark;

  const _AttentionRow({
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: iconColor.withOpacity(0.15),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Icon(
            CupertinoIcons.chevron_right,
            color: isDark ? Colors.white60 : Colors.black45,
            size: 20,
          ),
        ],
      ),
    );
  }
}
