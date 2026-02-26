import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../providers/settings_provider.dart';
import '../../providers/timer_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    final settings = ref.watch(notificationSettingsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          // ── Reapply Timer ─────────────────────────────────────────
          _SectionHeader(label: 'Reapply Timer'),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Iconify(
                Ph.hourglass_bold,
                color: AppColors.warmOrange,
                size: 24,
              ),
              title: Text('Reapply every', style: AppTextStyles.bodyLarge),
              trailing: Text(
                _formatInterval(timerState.intervalMinutes),
                style: AppTextStyles.bodyLarge,
              ),
              onTap: () =>
                  _showIntervalPicker(context, ref, timerState.intervalMinutes),
            ),
          ),

          const SizedBox(height: 28),

          // ── Morning Reminder ─────────────────────────────────────
          _SectionHeader(label: 'Morning Reminder'),
          const SizedBox(height: 6),
          _SectionDescription(
            text:
                'A daily alarm at a time you choose. Reminds you to put on '
                'sunscreen before you start your day — sent every morning '
                'regardless of the weather.',
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Iconify(
                    Ph.bell_bold,
                    color: AppColors.warmOrange,
                    size: 24,
                  ),
                  title: Text('Enable', style: AppTextStyles.bodyLarge),
                  value: settings.morningReminderEnabled,
                  activeThumbColor: AppColors.warmOrange,
                  onChanged: (v) => ref
                      .read(notificationSettingsProvider.notifier)
                      .setMorningReminderEnabled(v),
                ),
                if (settings.morningReminderEnabled) ...[
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const SizedBox(width: 24),
                    title: Text('Reminder time', style: AppTextStyles.bodyLarge),
                    trailing: Text(
                      _formatTime(settings.alertHour, settings.alertMinute),
                      style: AppTextStyles.bodyLarge,
                    ),
                    onTap: () => _pickTime(context, ref, settings),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ── Sunny Day Alert ───────────────────────────────────────
          _SectionHeader(label: 'Sunny Day Alert'),
          const SizedBox(height: 6),
          _SectionDescription(
            text:
                "Sent when today's UV forecast hits your threshold. You'll "
                'only get this alert on days that are actually sunny enough '
                'to need sunscreen — not every day.',
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Iconify(
                    Ph.sun_bold,
                    color: AppColors.warmOrange,
                    size: 24,
                  ),
                  title: Text('Enable', style: AppTextStyles.bodyLarge),
                  value: settings.uvAlertEnabled,
                  activeThumbColor: AppColors.warmOrange,
                  onChanged: (v) => ref
                      .read(notificationSettingsProvider.notifier)
                      .setUvAlertEnabled(v),
                ),
                if (settings.uvAlertEnabled) ...[
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const SizedBox(width: 24),
                    title: Text('Alert when UV reaches',
                        style: AppTextStyles.bodyLarge),
                    trailing: _UvBadge(threshold: settings.uvThreshold),
                    onTap: () =>
                        _showUvPicker(context, ref, settings.uvThreshold),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String _formatInterval(int minutes) {
    if (minutes < 60) return '$minutes min';
    final hours = minutes ~/ 60;
    final mins = minutes % 60;
    if (mins == 0) return '$hours hr';
    return '${hours}h ${mins}m';
  }

  String _formatTime(int hour, int minute) {
    final period = hour < 12 ? 'AM' : 'PM';
    final displayHour = hour == 0
        ? 12
        : hour > 12
            ? hour - 12
            : hour;
    final displayMinute = minute.toString().padLeft(2, '0');
    return '$displayHour:$displayMinute $period';
  }

  // ── Pickers ──────────────────────────────────────────────────────────────

  Future<void> _pickTime(BuildContext context, WidgetRef ref,
      NotificationSettingsState settings) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: settings.alertHour, minute: settings.alertMinute),
    );
    if (picked != null) {
      ref
          .read(notificationSettingsProvider.notifier)
          .setAlertTime(picked.hour, picked.minute);
    }
  }

  void _showIntervalPicker(
      BuildContext context, WidgetRef ref, int currentMinutes) {
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Reapply every', style: AppTextStyles.title),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...options.map((minutes) {
                        return ListTile(
                          title: Text(_formatInterval(minutes)),
                          trailing: minutes == currentMinutes
                              ? const Iconify(
                                  Ph.check_circle_bold,
                                  color: AppColors.warmOrange,
                                  size: 24,
                                )
                              : null,
                          onTap: () {
                            ref
                                .read(timerProvider.notifier)
                                .setInterval(minutes);
                            Navigator.pop(context);
                          },
                        );
                      }),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUvPicker(
      BuildContext context, WidgetRef ref, double currentThreshold) {
    // Thresholds mapped to WHO UV categories
    final options = <double, String>{
      2: 'UV 2+ · Low',
      3: 'UV 3+ · Moderate',
      6: 'UV 6+ · High',
      8: 'UV 8+ · Very High',
      11: 'UV 11+ · Extreme',
    };

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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text('Alert when UV reaches', style: AppTextStyles.title),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  'You\'ll be notified when today\'s UV forecast hits this level.',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ),
              ...options.entries.map((entry) {
                return ListTile(
                  title: Text(entry.value),
                  trailing: entry.key == currentThreshold
                      ? const Iconify(
                          Ph.check_circle_bold,
                          color: AppColors.warmOrange,
                          size: 24,
                        )
                      : null,
                  onTap: () {
                    ref
                        .read(notificationSettingsProvider.notifier)
                        .setUvThreshold(entry.key);
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

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTextStyles.title);
  }
}

class _SectionDescription extends StatelessWidget {
  final String text;

  const _SectionDescription({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(height: 1.5),
    );
  }
}

class _UvBadge extends StatelessWidget {
  final double threshold;

  const _UvBadge({required this.threshold});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'UV ${threshold.toInt()}+',
        style: GoogleFonts.figtree(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.warmOrange,
        ),
      ),
    );
  }
}
