import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/timer_provider.dart';

/// Primary CTA button — "I applied sunscreen!"
/// Starts (or restarts) the reapplication countdown timer.
class ApplyButton extends ConsumerWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () {
          HapticFeedback.mediumImpact();
          ref.read(timerProvider.notifier).applySunscreen();
        },
        icon: const Icon(Icons.wb_sunny_rounded),
        label: const Text('I applied sunscreen!'),
      ),
    );
  }
}
