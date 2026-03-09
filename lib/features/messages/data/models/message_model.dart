import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_slt/features/messages/data/models/message_fields.dart';
import 'package:new_slt/core/utils/enums.dart';

class MessageModel {
  final String? id;
  final String senderName;
  final String text;
  final DateTime date;
  final bool isPrivate;

  MessageModel({
    this.id,
    required this.senderName,
    required this.text,
    required this.date,
    required this.isPrivate,
  });

  factory MessageModel.fakeModel() {
    return MessageModel(
      senderName: 'فريق القادة الاجتماعيين',
      text: 'دي رسالة ملهاش اي لازمه ولا هيكون ليها اي لازمه',
      date: DateTime.now(),
      isPrivate: false,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json[MessageFields.id],
      senderName: json[MessageFields.senderName],
      text: json[MessageFields.text],
      date: (json[MessageFields.date] as Timestamp).toDate(),
      isPrivate: json[MessageFields.isPrivate],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      MessageFields.senderName: senderName,
      MessageFields.text: text,
      MessageFields.date: date,
      MessageFields.isPrivate: isPrivate,
    };
  }

  static String _notificationsMessages({
    required AppNotificationsMessages appNotificationsMessages,
    required String activityName,
  }) {
    if (appNotificationsMessages == AppNotificationsMessages.eventLeader) {
      return "انت الان مسؤول $activityName";
    } else if (appNotificationsMessages ==
        AppNotificationsMessages.addedToEvent) {
      return "تم إضافتك في $activityName";
    } else if (appNotificationsMessages ==
        AppNotificationsMessages.removedFromEvent) {
      return "تم حذفك من $activityName";
    } else if (appNotificationsMessages ==
        AppNotificationsMessages.namedLeader) {
      return "انت الان قائد $activityName";
    } else if (appNotificationsMessages ==
        AppNotificationsMessages.namedCaptain) {
      return "انت الان رائد $activityName";
    } else if (appNotificationsMessages ==
        AppNotificationsMessages.namedFemaleLeader) {
      return "انتي الان مسؤولة $activityName";
    } else {
      return "";
    }
  }

  factory MessageModel.notificationMessageModel({
    required AppNotificationsMessages appNotificationsMessages,
    required String activityName,
  }) {
    return MessageModel(
      senderName: "فريق القادة الاجتماعيين",
      text: _notificationsMessages(
        appNotificationsMessages: appNotificationsMessages,
        activityName: activityName,
      ),
      date: DateTime.now(),
      isPrivate: true,
    );
  }

  factory MessageModel.membersNotificationMessage({
    required String messageText,
    required bool isPrivate,
    
  }) {
    return MessageModel(
      senderName: "فريق القادة الاجتماعيين",
      text: messageText,
      date: DateTime.now(),
      isPrivate: isPrivate,
    );
  }

}
