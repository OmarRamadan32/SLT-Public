import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/data/repos/campaign_repo.dart';

part 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignRepo campaignRepo;
  CampaignCubit({required this.campaignRepo}) : super(CampaignInitialState());

  List<CampaignModel> campaigns = [];
  List<ActivityModel> activities = [];
  ActivityModel? activityModel;

  Future<void> getAllCampaigns() async {
    emit(CampaignLoadingState());
    var result = await campaignRepo.getAllCampaigns();
    result.fold((l) => emit(CampaignErrorState(message: l.message)), (r) {
      campaigns = r;
      if (!isClosed) emit(CamapaignSuccessState());
    });
  }

  Future<void> getCampaignActivities({required String campaignId}) async {
    emit(CampaignLoadingState());
    var result = await campaignRepo.getAllCampaignActivities(
      campaignId: campaignId,
    );
    result.fold((l) => emit(CampaignErrorState(message: l.message)), (r) {
      activities = r;
      if (!isClosed) emit(CamapaignSuccessState());
    });
  }

  Future<void> getActivityById({
    required String activityId,
    required String campaignId,
  }) async {
    emit(CampaignLoadingState());
    var result = await campaignRepo.getCampaignActivityById(
      campaignId: campaignId,
      activityId: activityId,
    );
    result.fold((l) => emit(CampaignActivityErrorState(message: l.message)), (r) {
      activityModel = r;
      emit(CamapaignSuccessState());
    });
  }
}
