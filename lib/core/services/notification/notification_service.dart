import 'package:flutter/material.dart';

abstract class NotificationService {
  // Future<void> sendNotification({
  //   required String deviceToken,
  //   required String title,
  //   required String body,
  // });
  Future<void> sendNotificationToAllTeamMembers({
    required String title,
    required String body,
  });

  Future<void> sendNotificationToUsers({
    required String title,
    required String body,
    required List<String> tokens,
  });
  Future<void> sendNotificationToAccessLevels({
    required int miniMumAccessLevel,
    required String title,
    required String body,
  });

  Future<void> saveTokenToDatabase();

  Future<void> requestNotificationPermission();

  Future<String?> getUserToken();

  Future<String?> getAccessToken();

  Future<void> showForegroundNotification(BuildContext context);
}