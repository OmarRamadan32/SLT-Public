import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_fields.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/data/repos/campaign_repo.dart';

part 'campaign_dashboard_state.dart';

class CampaignDashbaordCubit extends Cubit<CampaignDashboardState> {
  CampaignRepo campaignRepo;
  CampaignDashbaordCubit({required this.campaignRepo})
    : super(CampaignDashboardInitialState());
  CampaignModel? campaign;
  List<CampaignModel> campaigns = [];
  ActivityModel? activity;
  List<ActivityModel> activities = [];

  void resetState() {
    emit(CampaignDashboardInitialState());
  }

  Future<void> addCampaign({required CampaignModel campaignModel}) async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.addCampaign(campaignModel: campaignModel);
    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CampaignDashboardEventAddedState()),
    );
  }

  Future<void> addCampaignActivity({
    required ActivityModel activityModel,
  }) async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.addCampaignActivity(
      campaignId: campaign!.id!,
      activityModel: activityModel,
    );
    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CampaignDashboardEventAddedState()),
    );
  }

  Future<void> getAllCampaigns() async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.getAllCampaigns();
    result.fold((l) => emit(CampaignDashboardErrorState(error: l.message)), (
      r,
    ) {
      campaigns = r;
      if (!isClosed) emit(CampaignDashboardSuccessState());
    });
  }

  Future<void> getCampaignAndActivitiesById({
    required String campaignId,
  }) async {
    activities = [];
    campaign = null;
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.getCampaignById(campaignId: campaignId);
    var result2 = await campaignRepo.getAllCampaignActivities(
      campaignId: campaignId,
    );
    result.fold((l) => emit(CampaignDashboardErrorState(error: l.message)), (
      r,
    ) {
      campaign = r;
    });
    result2.fold((l) => emit(CampaignDashboardErrorState(error: l.message)), (
      r,
    ) {
      activities = r;
      emit(CampaignDashboardSuccessState());
    });
  }

  Future<void> getCampaignActivityById({required String activityId}) async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.getCampaignActivityById(
      campaignId: campaign!.id!,
      activityId: activityId,
    );
    result.fold((l) => emit(CampaignDashboardErrorState(error: l.message)), (
      r,
    ) {
      activity = r;
      emit(CampaignDashboardSuccessState());
    });
  }

  Future<void> changeCampaignLeader({
    required String newCampaignLeaderId,
    required String newCampaignLeaderIdFieldName,
    required String newCampaignLeaderNameFieldName,
    required String newCampaignLeaderName,
  }) async {
    emit(CampaignDashboardLoadingState());
    String oldCampaignLeaderId =
        newCampaignLeaderIdFieldName == CampaignFields.campaignLeaderId
            ? campaign!.campaignLeaderId
            : campaign!.campaignLeaderTwoId!;
    var result = await campaignRepo.changeCampaignLeader(
      oldCampaignLeaderId: oldCampaignLeaderId,
      campaignName: campaign!.campaignName,
      newCampaignLeaderName: newCampaignLeaderName,
      newCampaignLeaderNameFieldName: newCampaignLeaderNameFieldName,
      newCampaignLeaderIdFieldName: newCampaignLeaderIdFieldName,
      campaignId: campaign!.id!,
      newCampaignLeaderId: newCampaignLeaderId,
    );
    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CampaignDashboardLeaderChangedState()),
    );
  }

  Future<void> changeActivityLeader({
    required String oldActivityLeaderId,
    required String newActivityLeaderId,
    required String newActivityLeaderIdFieldName,
    required String newActivityLeaderNameFieldName,
    required String newActivityLeaderName,
  }) async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.changeActivityLeader(
      activityName: activity!.activityName,
      campaignId: campaign!.id!,
      activityId: activity!.id!,
      oldActivityLeaderId: oldActivityLeaderId,
      newActivityLeaderId: newActivityLeaderId,
      newActivityLeaderIdFieldName: newActivityLeaderIdFieldName,
      newActivityLeaderNameFieldName: newActivityLeaderNameFieldName,
      newActivityLeaderName: newActivityLeaderName,
    );

    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CampaignDashboardLeaderChangedState()),
    );
  }

  Future<void> addActivityMembers({required List<String> membersIds}) async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.addActivityMembers(
      activityName: activity!.activityName,
      campaignId: campaign!.id!,
      activityId: activity!.id!,
      membersIds: membersIds,
    );
    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CamapaignDashboardMembersUpdatedState()),
    );
  }

  Future<void> removeActivityMembers({required List<String> membersIds}) async {
    emit(CampaignDashboardLoadingState());
    var result = await campaignRepo.removeActivityMembers(
      activityName: activity!.activityName,
      campaignId: campaign!.id!,
      activityId: activity!.id!,
      membersIds: membersIds,
    );
    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CamapaignDashboardMembersUpdatedState()),
    );
  }

  Future<void> updateActivityDetails({
    required ActivityModel activityModel,
  }) async {
    var result = await campaignRepo.updateActivityDetails(
      activityId: activity!.id!,
      campaignId: campaign!.id!,
      activityModel: activityModel,
    );
    result.fold(
      (l) => emit(CampaignDashboardErrorState(error: l.message)),
      (r) => emit(CampaignDashboardSuccessState()),
    );
  }
}
