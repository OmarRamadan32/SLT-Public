import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_fields.dart';

class CampaignModel {
  final String campaignName;
  final String campaignImage;
  final int campaignNumber;
  final String? id;
  final String campaignLeaderId;
  final String campaignLeaderName;
  final String? campaignLeaderTwoId;
  final String? campaignLeaderTwoName;
  final bool isCurrent;
  final List<UserModel> campaignMembersModels;

  CampaignModel({
    required this.campaignName,
    required this.campaignImage,
    required this.campaignNumber,
    this.id,
    required this.campaignLeaderId,
    required this.campaignLeaderName,
    this.campaignLeaderTwoId,
    this.campaignLeaderTwoName,
    required this.isCurrent,
    required this.campaignMembersModels,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      campaignName: json[CampaignFields.campaignName],
      campaignImage: json[CampaignFields.campaignImage],
      campaignNumber: json[CampaignFields.campaignNumber],
      campaignLeaderId: json[CampaignFields.campaignLeaderId],
      isCurrent: json[CampaignFields.isCurrent],
      id: json[CampaignFields.campaignId],
      campaignLeaderName: json[CampaignFields.campaignLeaderName],
      campaignLeaderTwoId: json[CampaignFields.campaignLeaderTwoId] ?? '',
      campaignLeaderTwoName: json[CampaignFields.campaignLeaderTwoName],
      campaignMembersModels:
          List<UserModel>.from(
            json[CampaignFields.campaignMembersIds] ?? [],
          ).map((e) => e).toList(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      CampaignFields.campaignName: campaignName,
      CampaignFields.campaignImage: campaignImage,
      CampaignFields.campaignNumber: campaignNumber,
      CampaignFields.campaignLeaderId: campaignLeaderId,
      CampaignFields.isCurrent: isCurrent,
      CampaignFields.campaignLeaderName: campaignLeaderName,
      CampaignFields.campaignLeaderTwoId: campaignLeaderTwoId,
      CampaignFields.campaignLeaderTwoName: campaignLeaderTwoName,
      CampaignFields.campaignMembersIds: campaignMembersModels,
    };
  }
}
