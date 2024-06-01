import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    initializeNotifications();
  }

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        await AndroidNotificationDetails("channelId", "channelName",
            importance: Importance.high, priority: Priority.high);
    NotificationDetails notificaationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, title, body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificaationDetails,
      // const NotificationDetails(
      //   android: AndroidNotificationDetails('Taskapp', 'Taskapp',
      //       priority: Priority.high, importance: Importance.high),
      // ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
