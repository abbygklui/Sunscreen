import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../providers/timer_provider.dart';

/// Settings screen for configuring timer interval, alert time, and UV threshold.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          // Reapply interval
          Text('Timer', style: AppTextStyles.title),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.timer_rounded, color: AppColors.warmOrange),
              title: const Text('Reapply interval', style: AppTextStyles.bodyLarge),
              trailing: Text(
                _formatInterval(timerState.intervalMinutes),
                style: AppTextStyles.bodyLarge,
              ),
              onTap: () => _showIntervalPicker(context, ref, timerState.intervalMinutes),
            ),
          ),

          const SizedBox(height: 24),

          // Morning alert section
          Text('Morning Alert', style: AppTextStyles.title),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.alarm_rounded, color: AppColors.warmOrange),
                  title: const Text('Alert time', style: AppTextStyles.bodyLarge),
                  trailing: Text(
                    '7:00 AM', // TODO: Read from preferences
                    style: AppTextStyles.bodyLarge,
                  ),
                  onTap: () {
                    // TODO: Show time picker
                  },
                ),
                const Divider(height: 1, indent: 56),
                ListTile(
                  leading: const Icon(Icons.wb_sunny_rounded, color: AppColors.warmOrange),
                  title: const Text('UV threshold', style: AppTextStyles.bodyLarge),
                  trailing: Text(
                    'UV 3+', // TODO: Read from preferences
                    style: AppTextStyles.bodyLarge,
                  ),
                  onTap: () {
                    // TODO: Show threshold picker
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatInterval(int minutes) {
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return '$hours hr';
    return '${hours}h ${mins}m';
  }

  void _showIntervalPicker(BuildContext context, WidgetRef ref, int currentMinutes) {
    final options = [30, 60, 90, 120, 180, 240, 360, 480];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Reapply interval', style: AppTextStyles.title),
              ),
              ...options.map((minutes) {
                return ListTile(
                  title: Text(_formatInterval(minutes)),
                  trailing: minutes == currentMinutes
                      ? const Icon(Icons.check_rounded, color: AppColors.warmOrange)
                      : null,
                  onTap: () {
                    ref.read(timerProvider.notifier).setInterval(minutes);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
