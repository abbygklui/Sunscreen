import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Initialize notification service
  // TODO: Initialize workmanager for background UV checks
  // TODO: Initialize alarm manager for timer

  runApp(
    const ProviderScope(
      child: SunscreenApp(),
    ),
  );
}
