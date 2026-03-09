import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_slt/features/schedule/data/models/schedule_fields.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';

class ScheduleModel {
  final String scheduleTitle;
  final String scheduleContent;
  final String scheduleAuthorId;
  final DateTime scheduleDate;

  final String? id;
  final List<UserModel>? scheduleAtts;

  ScheduleModel({
    required this.scheduleTitle,
    required this.scheduleContent,
    required this.scheduleAuthorId,
    required this.scheduleDate,
    required this.scheduleAtts,
    this.id,
  });
  factory ScheduleModel.fakeModel() {
    return ScheduleModel(
      scheduleAtts: [],
      scheduleAuthorId: '123',
      scheduleContent:
          'اجتماع فريق مهم جدا اللي مش هيجي هقتله اثبت ياعم انت وهو محدش رايح في حتي من هنا',
      scheduleDate: DateTime.now(),
      scheduleTitle: 'اجتماع فريق مهم',
      id: '123',
    );
  }

  factory ScheduleModel.fromJson(json) {
    return ScheduleModel(
      scheduleAtts: List<UserModel>.from(
        (json[ScheduleFields.scheduleAtts] ?? []).map((e) => e as UserModel),
      ),
      scheduleAuthorId: json[ScheduleFields.scheduleAuthorId],
      scheduleContent: json[ScheduleFields.scheduleContent],
      scheduleDate: (json[ScheduleFields.scheduleDate] as Timestamp).toDate(),
      scheduleTitle: json[ScheduleFields.scheduleTitle],
      id: json[ScheduleFields.scheduleId],
    );
  }
  factory ScheduleModel.fromJsonWithoutAtts(json) {
    return ScheduleModel(
      scheduleAuthorId: json[ScheduleFields.scheduleAuthorId],
      scheduleContent: json[ScheduleFields.scheduleContent],
      scheduleDate: (json[ScheduleFields.scheduleDate] as Timestamp).toDate(),
      scheduleAtts: [],
      scheduleTitle: json[ScheduleFields.scheduleTitle],
      id: json[ScheduleFields.scheduleId],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ScheduleFields.scheduleTitle: scheduleTitle,
      ScheduleFields.scheduleContent: scheduleContent,
      ScheduleFields.scheduleAuthorId: scheduleAuthorId,
      ScheduleFields.scheduleDate: scheduleDate,
      ScheduleFields.scheduleAtts: scheduleAtts,
    };
  }

  String scheduleMonth() {
    // List<String> globalMonths = [
    //   "January",
    //   "February",
    //   "March",
    //   "April",
    //   "May",
    //   "June",
    //   "July",
    //   "August",
    //   "September",
    //   "October",
    //   "November",
    //   "December",
    // ];
    List<String> arabicMonths = [
      "يناير",
      "فبراير",
      "مارس",
      "ابريل",
      "مايو",
      "يونيو",
      "يوليو",
      "اغسطس",
      "سبتمبر",
      "اكتوبر",
      "نوفمبر",
      "ديسمبر",
    ];
    return arabicMonths[scheduleDate.month.toInt() - 1];
  }
}
