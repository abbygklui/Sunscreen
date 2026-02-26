import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../settings/settings_screen.dart';
import 'widgets/uv_card.dart';
import 'widgets/timer_ring.dart';
import 'widgets/apply_button.dart';

/// Main home screen showing UV info and reapplication timer.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunscreen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            color: AppColors.warmGray,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              UvCard(),
              SizedBox(height: 24),
              TimerRing(),
              SizedBox(height: 32),
              ApplyButton(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
