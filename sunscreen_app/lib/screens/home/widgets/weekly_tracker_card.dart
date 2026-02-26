import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../providers/weekly_tracker_provider.dart';

class WeeklyTrackerCard extends ConsumerWidget {
  const WeeklyTrackerCard({super.key});

  static const List<String> _labels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const int _maxDots = 4;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracker = ref.watch(weeklyTrackerProvider);
    final todayIndex = DateTime.now().weekday - 1; // 0=Mon, 6=Sun
    final streak = _calcStreak(tracker.counts, todayIndex);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFECB3), // cream
              Color(0xFFFFF8E1), // cloudWhite
            ],
          ),
        ),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Iconify(Ph.sun_bold, color: AppColors.warmOrange, size: 18),
                    const SizedBox(width: 6),
                    Text('This Week', style: AppTextStyles.title),
                  ],
                ),
                if (streak > 0) _StreakBadge(streak: streak),
              ],
            ),
            const SizedBox(height: 24),
            // ── Day columns ─────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (i) {
                return _DayColumn(
                  label: _labels[i],
                  count: tracker.counts[i],
                  maxDots: _maxDots,
                  isToday: i == todayIndex,
                  isFuture: i > todayIndex,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  int _calcStreak(List<int> counts, int todayIndex) {
    int streak = 0;
    for (int i = todayIndex; i >= 0; i--) {
      if (counts[i] > 0) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }
}

// ── Streak badge ──────────────────────────────────────────────────────────────

class _StreakBadge extends StatelessWidget {
  final int streak;

  const _StreakBadge({required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.warmOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$streak day${streak == 1 ? '' : 's'} ✦',
        style: GoogleFonts.figtree(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

// ── Single day column ─────────────────────────────────────────────────────────

class _DayColumn extends StatelessWidget {
  final String label;
  final int count;
  final int maxDots;
  final bool isToday;
  final bool isFuture;

  const _DayColumn({
    required this.label,
    required this.count,
    required this.maxDots,
    required this.isToday,
    required this.isFuture,
  });

  @override
  Widget build(BuildContext context) {
    final filledCount = count.clamp(0, maxDots);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dot stack — grows upward (column top = topmost dot slot)
        SizedBox(
          height: maxDots * 11.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(maxDots, (i) {
              // i=0 is the top slot; fill from the bottom up
              final slotIndex = maxDots - 1 - i;
              final filled = slotIndex < filledCount;
              return Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: _Dot(filled: filled, isFuture: isFuture),
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
        // Day label
        Container(
          width: 28,
          height: 28,
          decoration: isToday
              ? BoxDecoration(
                  color: AppColors.warmOrange,
                  borderRadius: BorderRadius.circular(14),
                )
              : null,
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.figtree(
                fontSize: 12,
                fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                color: isToday
                    ? Colors.white
                    : isFuture
                        ? AppColors.cream
                        : AppColors.warmGray,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Single dot ────────────────────────────────────────────────────────────────

class _Dot extends StatelessWidget {
  final bool filled;
  final bool isFuture;

  const _Dot({required this.filled, required this.isFuture});

  @override
  Widget build(BuildContext context) {
    final Color color;
    if (filled) {
      color = AppColors.warmOrange;
    } else if (isFuture) {
      color = const Color(0xFFFFECB3); // cream — almost invisible on gradient
    } else {
      color = const Color(0xFFFFD8A0); // warm placeholder
    }

    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: filled ? color : Colors.transparent,
        border: filled
            ? null
            : Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
