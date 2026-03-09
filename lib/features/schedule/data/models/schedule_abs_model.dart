import 'package:new_slt/features/schedule/data/models/schedule_abs_fields.dart';

class ScheduleAbsModel {
  final String absId;
  final String absReason;
  final bool isApproved;
  final String userName;
  final String userImage;

  ScheduleAbsModel({
    required this.absId,
    required this.absReason,
    required this.isApproved,
    required this.userName,
    required this.userImage
  });

  factory ScheduleAbsModel.fromJson(Map<String, dynamic> json) {
    return ScheduleAbsModel(
      absId: json[ScheduleAbsFields.absId],
      absReason: json[ScheduleAbsFields.absReason],
      isApproved: json[ScheduleAbsFields.isApproved],
      userName: json[ScheduleAbsFields.userName],
      userImage: json[ScheduleAbsFields.userImage],
    );
  }

  Map<String, dynamic> toJson() => {
    ScheduleAbsFields.absId: absId,
    ScheduleAbsFields.absReason: absReason,
    ScheduleAbsFields.isApproved: isApproved,
    ScheduleAbsFields.userName: userName,
    ScheduleAbsFields.userImage: userImage
  };
}
