import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:note_reminder_getx/noti_page_test.dart';

class NotificationController {
  /// Handle when a new notification or schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Implement your logic here
  }

  /// Handle when a notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Implement your logic here
  }

  /// Handle when the user dismisses a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Implement your logic here
  }

  /// Handle when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Log the received action details
    log('Received Action:');
    log('Action ID: ${receivedAction.id}');
    log('Action Type: ${receivedAction.actionType}');
    log('Payload: ${receivedAction.payload}');
    String title = receivedAction.payload?['title'] ?? 'No title';
    String body = receivedAction.payload?['body'] ?? 'No body';

    // Navigate to NotiPageTest with title and body
    Get.to(() => NotiPageTest(title: title, body: body));
    //alreay nivigate
    log("alreay nivigate");
  }
}
