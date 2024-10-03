import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pegadaian_digital/helpers/colors_custom.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationPlugin {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final BehaviorSubject<ReceivedNotifcation>
      didReceivedLocalNotifiactionSubject =
      BehaviorSubject<ReceivedNotifcation>();
  late InitializationSettings initializationSettings;

  static const int insistentFlag = 4;

  NotificationPlugin._() {
    init();
  }

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      _requestIOSPermissionNotification();
    }
    initializePlatformSpecifics();
    tz.initializeTimeZones();
  }

  initializePlatformSpecifics() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        ReceivedNotifcation receivedNotifcation =
            // ignore: missing_required_param
            ReceivedNotifcation(
                id: id,
                title: title,
                body: body,
                payload: title,
                time: DateTime.now(),
                audio: '',
                soundStatus: '');
        didReceivedLocalNotifiactionSubject.add(receivedNotifcation);
      },
    );
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _requestIOSPermissionNotification() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotifiactionSubject.stream.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }

  void setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      onNotificationClick(response.payload);
    });
  }

  Future<void> showNotification(
      ReceivedNotifcation notification) async {
    AndroidNotificationDetails androidChannelSpecifics =
        AndroidNotificationDetails(
            notification.id.toString(), notification.title ?? '',
            channelDescription: notification.body,
            priority: Priority.max,
            importance: Importance.max,
            playSound: false,
            enableLights: true,
            color: ColorsCustom.primary,
            ledColor: ColorsCustom.primary,
            ledOnMs: 1000,
            ledOffMs: 500,
            styleInformation: const BigTextStyleInformation(''),
            additionalFlags: Int32List.fromList(<int>[insistentFlag]));
    DarwinNotificationDetails iosChannelSpecifics = DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidChannelSpecifics, iOS: iosChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(notification.id,
        notification.title, notification.body, platformChannelSpecifics);
  }
}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotifcation {
  final int id;
  final DateTime time;
  final String? title, body, soundStatus, audio, payload;

  ReceivedNotifcation(
      {required this.id,
      this.title,
      this.body,
      required this.time,
      this.soundStatus,
      this.audio,
      this.payload});
}

class ReceivedNotifcationWithImage {
  final int id;
  final String? title, body, payload, imageLink;

  ReceivedNotifcationWithImage({
    required this.id,
    this.title,
    this.body,
    this.payload,
    this.imageLink,
  });
}
