import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';

class AwesomeNotificationHelper {
  // Method to schedule a notification at a specific date and time
  static void scheduleNotificationWithDateTime(String title, String body,
      int year, int month, int day, int hour, int minute, {String? summary}) {
    int notificationUniqueId = Random().nextInt(100);
    DateTime scheduledDate = DateTime(year, month, day, hour, minute);

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationUniqueId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary, // Adding summary to the notification content
        payload: {'title': title, 'body': body}, // Adding payload here
      ),
      schedule: NotificationCalendar.fromDate(
        date: scheduledDate,
        allowWhileIdle: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          autoDismissible: true,
        ),
      ],
    );
  }

  // Method to show a simple notification immediately
  static void showSimpleNotification(String title, String body, {String? summary}) {
    int notificationUniqueId = Random().nextInt(100);

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationUniqueId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary, // Adding summary to the notification content
        payload: {'title': title, 'body': body}, // Adding payload here
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          autoDismissible: true,
        ),
      ],
    );
  }

  // Method to schedule a daily notification at a specific time
  static void scheduleDailyNotification(String title, String body, int hour, int minute, {String? summary}) {
    int notificationUniqueId = Random().nextInt(100);

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationUniqueId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        summary: summary, // Adding summary to the notification content
        payload: {'title': title, 'body': body}, // Adding payload here
      ),
      schedule: NotificationCalendar(
        hour: hour,
        minute: minute,
        second: 0,
        millisecond: 0,
        repeats: true,
        allowWhileIdle: true,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'VIEW',
          label: 'View Details',
          autoDismissible: true,
        ),
      ],
    );
  }
}
