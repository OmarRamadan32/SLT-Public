import 'package:dartz/dartz.dart';
import 'package:new_slt/core/errors/failure.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';

abstract class CampaignRepo {
  // --Campaigns
  Future<Either<Failure, void>> addCampaign({
    required CampaignModel campaignModel,
  });

  Future<Either<Failure, void>> changeCampaignLeader({
    required String campaignId,
    required String newCampaignLeaderId,
    newCampaignLeaderIdFieldName,
    newCampaignLeaderNameFieldName,
    required String newCampaignLeaderName,
    required String oldCampaignLeaderId,
    required String campaignName
  });
  Future<Either<Failure, List<CampaignModel>>> getAllCampaigns();

  Future<Either<Failure, CampaignModel>> getCampaignById({
    required String campaignId,
  });
  // --Activities
  Future<Either<Failure, void>> addCampaignActivity({
    required String campaignId,
    required ActivityModel activityModel,
    
  });
  Future<Either<Failure, void>> changeActivityLeader({
    required String campaignId,
    required String activityId,
    required String oldActivityLeaderId,
    required String newActivityLeaderId,
    required String newActivityLeaderIdFieldName,
    required String newActivityLeaderNameFieldName,
    required String newActivityLeaderName,
    required String activityName
  });

  Future<Either<Failure, List<ActivityModel>>> getAllCampaignActivities({
    required String campaignId,
  });

  Future<Either<Failure, ActivityModel>> getCampaignActivityById({
    required String campaignId,
    required String activityId,
  });

  Future<Either<Failure, void>> addActivityMembers({
    required String campaignId,
    required String activityId,
    required List<String> membersIds,
        required String activityName,
  });
  Future<Either<Failure, void>> removeActivityMembers({
    required String campaignId,
    required String activityId,
    required List<String> membersIds,
    required String activityName,
  });
  Future<Either<Failure, void>> updateActivityDetails({
    required ActivityModel activityModel,
    required String campaignId,
    required String activityId,
  });
}
