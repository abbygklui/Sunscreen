import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../core/constants.dart';

/// Manages local push notifications for UV alerts and timer reminders.
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Initializes the notification plugin and channels.
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);
    await _plugin.initialize(settings);
  }

  /// Sends a UV alert notification.
  Future<void> showUvAlert({required double uvIndex}) async {
    const androidDetails = AndroidNotificationDetails(
      AppConstants.uvAlertChannelId,
      AppConstants.uvAlertChannelName,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      0,
      'Sunscreen',
      "It's a sunny one today (UV ${uvIndex.round()})! Don't forget your sunscreen!",
      const NotificationDetails(android: androidDetails),
    );
  }

  /// Sends a reapplication reminder notification.
  Future<void> showReapplyReminder() async {
    const androidDetails = AndroidNotificationDetails(
      AppConstants.timerChannelId,
      AppConstants.timerChannelName,
      importance: Importance.high,
      priority: Priority.high,
    );

    await _plugin.show(
      1,
      'Sunscreen',
      'Time to reapply! Your skin will thank you.',
      const NotificationDetails(android: androidDetails),
    );
  }
}
