import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Duration intervalBetweenNotifications = const Duration(minutes: 1);
  static Duration intervalBetweenNightNotifications = const Duration(minutes: 1);
  static DateTime endTime = DateTime.now().add(Duration(minutes:30));
  static DateTime endTimeNight = DateTime.now().add(Duration(minutes:30));


  static Future<void> onDidReceiveNotification(
      NotificationResponse response) async {
    if (response.payload == 'play_azan') {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/sounds/beautifull_azan.mp3"),
        autoStart: true,
        showNotification: true,
      );
    } else if (response.payload == 'stop_azan') {
      AssetsAudioPlayer.newPlayer().stop();
    }
  }

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:(NotificationResponse response) {
      print("Notification clicked with payload: ${response.payload}");
    },
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showInstantNotification(String title, String body) async
  {
    const  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
          "channel_Id",
          "channel_Name",
          channelDescription: 'description',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true
      ),
      iOS: DarwinNotificationDetails(),
    );
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }

  static Future<void> scheduleNotification(
      List<String> messages, DateTime time,Duration separateTime,DateTime endTime) async {
    tz.TZDateTime scheduledTime = tz.TZDateTime.from(
     time,
        tz.local
    );

    tz.TZDateTime stopTime = tz.TZDateTime.from(
        endTime,
        tz.local
    );
    const  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        "channel_IdMorning",
        "morning_azkar",
        channelDescription: 'morningAzkar',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }

    for (int i = 0; i < messages.length; i++) {
      if (scheduledTime.isBefore(stopTime)) {
        tz.TZDateTime notifyTime = tz.TZDateTime.from(scheduledTime, tz.local);

      tz.TZDateTime notificationTime =
      notifyTime.add(Duration(seconds: i * separateTime.inSeconds));
      print("Notification scheduled at: $notificationTime");


     await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        "Morning Azkar",
        messages[i],
       notificationTime,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
      );
      print("Notification scheduled: ${messages[i]} at $notificationTime");

    }else {
        print("Notification skipped: ${messages[i]} (end time reached)");
        break;
      }
    print("+++++++++++++++++++++++++++++++++++++++++++++++");
    print(tz.TZDateTime.now);
  }
  }
  static Future<void> nightScheduleNotification(
      List<String> messages, DateTime time,Duration separateTime,DateTime endTime) async {
    tz.TZDateTime scheduledTime = tz.TZDateTime.from(
        time,
        tz.local
    );

    tz.TZDateTime stopTime = tz.TZDateTime.from(
        endTime,
        tz.local
    );

    const  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
          "channel_IdNight",
          "night_azkar",
          channelDescription: 'nightAzkar',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true
      ),
      iOS: DarwinNotificationDetails(),
    );
    if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }

    for (int i = 0; i < messages.length; i++) {
      if (scheduledTime.isBefore(stopTime)) {
        tz.TZDateTime notifyTime = tz.TZDateTime.from(scheduledTime, tz.local);

        tz.TZDateTime notificationTime =
        notifyTime.add(Duration(seconds: i * separateTime.inSeconds));
        print("Notification scheduled at: $notificationTime");


        await flutterLocalNotificationsPlugin.zonedSchedule(
          i,
          "Night Azkar",
          messages[i],
          notificationTime,
          platformChannelSpecifics,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time, // Repeat daily
        );
        print("Notification scheduled: ${messages[i]} at $notificationTime");

      }else {
        print("Notification skipped: ${messages[i]} (end time reached)");
        break;
      }
      print("+++++++++++++++++++++++++++++++++++++++++++++++");
      print(tz.TZDateTime.now);
    }
  }

  static Future<void> schedulePrayerNotification(
      int id, String title, String body, DateTime time) async {
    tz.TZDateTime scheduledTime = tz.TZDateTime.from(time, tz.local);

    if (scheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledTime = scheduledTime.add(Duration(days: 1));
    }
    const  NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
          "channel_IdPray",
          "pray_channel",
          channelDescription: 'prayer times',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        sound: RawResourceAndroidNotificationSound('beautifull_azan'),
      actions: [
        AndroidNotificationAction(
          'play_azan',
          'Play Azan',
        ),
        AndroidNotificationAction(
          'stop_azan',
          'Stop Azan',
        ),
      ],
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print("Notification scheduled: ${title} at $scheduledTime");
  }
  static Future<void> cancelNotificationsForChannel(String channelId) async {
    final pendingNotifications =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (var notification in pendingNotifications) {
      if (notification.id.toString().contains(channelId)) {
        await flutterLocalNotificationsPlugin.cancel(notification.id);
      }
    }
    print("Canceled all notifications for channel: $channelId");
  }
}
