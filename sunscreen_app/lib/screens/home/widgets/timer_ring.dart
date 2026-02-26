import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../providers/timer_provider.dart';

/// Circular countdown ring showing time until next reapplication.
class TimerRing extends ConsumerWidget {
  const TimerRing({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    if (!timerState.isActive) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Tap below to start your\nsunscreen timer!',
            style: AppTextStyles.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final remaining = timerState.remaining;
    final total = Duration(minutes: timerState.intervalMinutes);
    final progress = total.inSeconds > 0
        ? remaining.inSeconds / total.inSeconds
        : 0.0;

    final hours = remaining.inHours;
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);

    final timeText = hours > 0
        ? '${hours}h ${minutes.toString().padLeft(2, '0')}m'
        : '${minutes}:${seconds.toString().padLeft(2, '0')}';

    final ringColor = timerState.isExpired
        ? AppColors.timerComplete
        : AppColors.timerActive;

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              backgroundColor: AppColors.cream,
              valueColor: AlwaysStoppedAnimation<Color>(ringColor),
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                timerState.isExpired ? 'Reapply!' : timeText,
                style: AppTextStyles.display.copyWith(color: ringColor),
              ),
              if (!timerState.isExpired)
                const Text('remaining', style: AppTextStyles.body),
            ],
          ),
        ],
      ),
    );
  }
}
