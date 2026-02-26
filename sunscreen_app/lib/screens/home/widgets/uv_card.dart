import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/uv_helpers.dart';
import '../../../providers/weather_provider.dart';

/// Card displaying today's UV index with a friendly message.
class UvCard extends ConsumerWidget {
  const UvCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uvData = ref.watch(uvDataProvider);

    return uvData.when(
      data: (weather) {
        final uv = weather.uvIndexMax;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text("Today's UV", style: AppTextStyles.label),
                const SizedBox(height: 12),
                Icon(
                  Icons.wb_sunny_rounded,
                  size: 48,
                  color: UvHelpers.uvColor(uv),
                ),
                const SizedBox(height: 8),
                Text(
                  uv.round().toString(),
                  style: AppTextStyles.display.copyWith(
                    color: UvHelpers.uvColor(uv),
                  ),
                ),
                Text(
                  UvHelpers.uvLabel(uv).toUpperCase(),
                  style: AppTextStyles.label.copyWith(
                    color: UvHelpers.uvColor(uv),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  UvHelpers.uvMessage(uv),
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (error, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.cloud_off_rounded, size: 48, color: AppColors.warmGray),
              const SizedBox(height: 8),
              Text(
                'Could not load UV data',
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
