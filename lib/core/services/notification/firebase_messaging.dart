import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:new_slt/core/services/database/data_base_service.dart';
import 'package:new_slt/core/services/notification/notification_service.dart';
import 'package:new_slt/features/user/data/models/user_fields.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';

class FirebaseMessaggingService implements NotificationService {
  final Dio _dio = Dio();
  final DatabaseService db;

  FirebaseMessaggingService({required this.db});

  @override
  Future<String> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": dotenv.env['PROJECT_ID'] ?? '',
      "private_key_id": dotenv.env['PRIVATE_KEY_ID'] ?? '',
      "private_key": (dotenv.env['PRIVATE_KEY'] ?? '').replaceAll(r'\n', '\n'),
      "client_email": dotenv.env['CLIENT_EMAIL'] ?? '',
      "client_id": "106638719139739416547",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/sendnotification%40slttest-c3845.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com",
    };

    const scopes = ["https://www.googleapis.com/auth/firebase.messaging"];

    final client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    return credentials.accessToken.data;
  }

  Future<void> _sendBulkNotifications({
    required List<String> tokens,
    required String title,
    required String body,
  }) async {
    // 1. تأكد أن القائمة ليست فارغة
    if (tokens.isEmpty) return;

    try {
      // 2. جلب التوكن "مرة واحدة" فقط لكل العملية لضمان السرعة
      final String accessToken = await getAccessToken();

      // 3. تحديد حجم المجموعة (Chunk Size)
      // إرسال 20 في كل مرة هو رقم مثالي للموبايل
      int chunkSize = 20;

      for (var i = 0; i < tokens.length; i += chunkSize) {
        // حساب نهاية المجموعة الحالية (لتجنب الخروج عن نطاق القائمة)
        int end =
            (i + chunkSize < tokens.length) ? i + chunkSize : tokens.length;

        // اقتطاع المجموعة الحالية
        var chunk = tokens.sublist(i, end);

        // 4. إرسال المجموعة الحالية بالتوازي
        await Future.wait(
          chunk.map(
            (token) => _sendSingleNotification(
              deviceToken: token,
              title: title,
              body: body,
              accessToken: accessToken,
            ),
          ),
        );

        // 5. تأخير بسيط جداً (50 مللي ثانية)
        // هذا السطر هو "السر" الذي يجعل شاشة الموبايل لا تتوقف (No Freeze)
        await Future.delayed(const Duration(milliseconds: 50));

        print('✅ تم إرسال مجموعة: من $i إلى $end');
      }

      print('🚀 تم الانتهاء من إرسال جميع الإشعارات بنجاح');
    } catch (e) {
      print('❌ خطأ في عملية الإرسال الجماعي: $e');
    }
  }

  Future<void> _sendSingleNotification({
    required String? deviceToken, // جعلناه يستقبل null للأمان
    required String title,
    required String body,
    required String accessToken,
  }) async {
    // empty tokens are not valid
    if (deviceToken == null || deviceToken.trim().isEmpty) {
      return;
    }
    // valid tokens must be at least 10 characters
    if (deviceToken.length < 10) {
      return;
    }

    const String endpointFCM =
        'https://fcm.googleapis.com/v1/projects/slttest-c3845/messages:send';

    final Map<String, dynamic> message = {
      "message": {
        "token": deviceToken,
        "notification": {"title": title, "body": body},
        "data": {"route": "/"},
      },
    };

    try {
      await _dio.post(
        endpointFCM,
        data: jsonEncode(message),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 400) {
        print('❌ Invalid Token: $deviceToken - (Should be removed from DB)');
      } else {
        print('❌ FCM Error: ${e.response?.statusCode}');
      }
    } catch (e) {
      print('❌ Unknown Error: $e');
    }
  }


  @override
  Future<void> saveTokenToDatabase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      await db.updateData(
        documentId: userId,
        path: BackendEndpoints.usersCollection,
        data: {UserFields.userToken: token},
      );
    }
  }

  @override
  Future<void> requestNotificationPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Future<String?> getUserToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  @override
  showForegroundNotification(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }

  // Send notifications methods

  @override
  Future<void> sendNotificationToAllTeamMembers({
    required String title,
    required String body,
  }) async {
    // get all team tokens
    List<Map<String, dynamic>> teamMembers = await db.getData(
      path: BackendEndpoints.usersCollection,
      query: {
        'where': [
          {
            'field': UserFields.userAccountType,
            'isEqualTo': Constants.normalMember,
          },
        ],
      },
    );
    List<String> tokens =
        teamMembers
            .map(
              (e) => e[UserFields.userToken] as String?,
            ) // استلامه كـ String قابل للـ null
            .where(
              (token) => token != null && token.isNotEmpty,
            ) // تصفية القيم الفارغة
            .cast<String>() // تحويل القائمة النهائية لـ List<String>
            .toList();
    await _sendBulkNotifications(tokens: tokens, title: title, body: body);
  }

  @override
  Future<void> sendNotificationToUsers({
    required String title,
    required String body,
    required List<String> tokens,
  }) async {
    List<String> tokensList =
        tokens.where((token) => token.isNotEmpty).toList();
    await _sendBulkNotifications(tokens: tokensList, title: title, body: body);
  }

  @override
  Future<void> sendNotificationToAccessLevels({
    required int miniMumAccessLevel,
    required String title,
    required String body,
  }) async {
    final String usersCollection = BackendEndpoints.usersCollection;
    List<Map<String, dynamic>> users = await db.getData(
      path: usersCollection,
      query: {
        'where': [
          {
            'field': UserFields.userAccessLevel,
            'isGreaterThanOrEqualTo': miniMumAccessLevel,
          },
        ],
      },
    );
    List<String> tokens =
        users
            .map(
              (e) => e[UserFields.userToken] as String?,
            ) // استلامه كـ String قابل للـ null
            .where(
              (token) => token != null && token.isNotEmpty,
            ) // تصفية القيم الفارغة
            .cast<String>() // تحويل القائمة النهائية لـ List<String>
            .toList();
    await _sendBulkNotifications(tokens: tokens, title: title, body: body);
  }
}
  // // NO LONGER NEEDED
  // @override
  // Future<void> sendNotification({
  //   required String deviceToken,
  //   required String title,
  //   required String body,
  // }) async {
  //   final String accessToken = await getAccessToken();
  //   const String endpointFCM =
  //       'https://fcm.googleapis.com/v1/projects/slttest-c3845/messages:send';

  //   final Map<String, dynamic> message = {
  //     "message": {
  //       "token": deviceToken,
  //       "notification": {"title": title, "body": body},
  //       "data": {"route": "/"},
  //     },
  //   };

  //   try {
  //     final response = await _dio.post(
  //       endpointFCM,
  //       data: jsonEncode(message),
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $accessToken',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       print('✅ Notification sent successfully');
  //     } else {
  //       print('❌ Failed to send notification - ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('❌ Dio error while sending notification: $e');
  //   }
  // }
