import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/campaigns/data/models/activity_fielda.dart';

class ActivityModel {
  String? id;
  int? activityCampaignNumber;
  final String activityName;
  final String activityDescription;
  final String activityImage;
  String? activityLeaderId;
  String? activityLeaderName;
  String? activityLeaderTwoId;
  String? activityLeaderTwoName;
  List<UserModel>? activityMembers;

  ActivityModel({
    this.id,
    required this.activityName,
    required this.activityDescription,
    required this.activityImage,
    required this.activityLeaderId,
    required this.activityLeaderName,
    required this.activityLeaderTwoId,
    this.activityLeaderTwoName,
    required this.activityMembers,
    required this.activityCampaignNumber,
  });

  ActivityModel.forUpdate({
    this.id,
    required this.activityName,
    required this.activityDescription,
    required this.activityImage,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json[ActivityFields.activityId],
      activityName: json[ActivityFields.activityName],
      activityDescription: json[ActivityFields.activityDescription],
      activityImage: json[ActivityFields.activityImage],
      activityLeaderId: json[ActivityFields.activityLeaderId] ?? '',
      activityLeaderName: json[ActivityFields.activityLeaderName],
      activityLeaderTwoId: json[ActivityFields.activityLeaderTwoId] ?? '',
      activityLeaderTwoName: json[ActivityFields.activityLeaderTwoName],
      activityMembers: List<UserModel>.from(
        (json[ActivityFields.activityMembers] ?? []).map((e) => e as UserModel),
      ),
      activityCampaignNumber: json[ActivityFields.activityCampaignNumber],
    );
  }

  Map<String, Object?> toJson() {
    return {
      ActivityFields.activityName: activityName,
      ActivityFields.activityCampaignNumber: activityCampaignNumber,
      ActivityFields.activityDescription: activityDescription,
      ActivityFields.activityImage: activityImage,
      ActivityFields.activityLeaderId: activityLeaderId,
      ActivityFields.activityLeaderName: activityLeaderName,
      ActivityFields.activityLeaderTwoId: activityLeaderTwoId,
      ActivityFields.activityLeaderTwoName: activityLeaderTwoName,
      ActivityFields.activityMembers: activityMembers,
    };
  }

  Map<String, String> toJsonUpdate() {
    return {
      ActivityFields.activityName: activityName,
      ActivityFields.activityDescription: activityDescription,
      ActivityFields.activityImage: activityImage,
    };
  }
}
