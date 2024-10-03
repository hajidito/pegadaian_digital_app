import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pegadaian_digital/utils/notification_plugin.dart';

class FirebaseUtils {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  static Future<void> firebaseHandler(RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
      print('Message data: ${message.notification?.title}');
    }
    final deviceToken = await getToken();

    // Verifying token availability
    if (deviceToken != null) {
      debugPrint('Device Token: $deviceToken');
      notificationPlugin.showNotification(ReceivedNotifcation(
          id: 1,
          time: DateTime.now(),
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: message.data['payload'] ?? ''));

      // Initializing notification service
    }
  }

  static Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );

    // Enable foreground notifications
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }
}
