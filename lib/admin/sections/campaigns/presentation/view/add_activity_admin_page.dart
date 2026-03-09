import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';

class AddActivityAdminPage extends StatefulWidget {
  const AddActivityAdminPage({super.key, required this.campaignId});
  final String campaignId;

  @override
  State<AddActivityAdminPage> createState() => _AddActivityAdminPageState();
}

class _AddActivityAdminPageState extends State<AddActivityAdminPage> {
  Future<void> addActivityFunction() async {
    CampaignDashbaordCubit campaignDashbaordCubit =
        context.read<CampaignDashbaordCubit>();
    UserCubit userCubit = context.read<UserCubit>();
    if (userCubit.imageFile != null &&
        activityNameController.text.isNotEmpty &&
        activityDetailsController.text.isNotEmpty &&
        userCubit.selectedUser != null) {
      final String folderPath =
          '${BackendEndpoints.campaignsFolder}/${campaignDashbaordCubit.campaign!.campaignName} ${campaignDashbaordCubit.campaign!.campaignNumber}';
      Helpers.showSnackBar(context, "جاري رفع صورة النشاط أولا");
      await userCubit.uploadImage(
        path: userCubit.imageFile!.path,
        folderName: folderPath,
      );
      ActivityModel activityModel = ActivityModel(
        activityLeaderName: userCubit.selectedUser!.name,
        activityName: activityNameController.text,
        activityDescription: activityDetailsController.text,
        activityImage: userCubit.imageUrl!,
        activityLeaderId: userCubit.selectedUser!.id!,
        activityLeaderTwoName: userCubit.selectedUserTwo?.name,
        activityLeaderTwoId: userCubit.selectedUserTwo?.id,
        activityMembers: [],
        activityCampaignNumber: campaignDashbaordCubit.campaign!.campaignNumber,
      );
      await campaignDashbaordCubit.addCampaignActivity(
        activityModel: activityModel,
      );
    } else {
      Helpers.showSnackBar(context, "من فضلك قم بتعبئة جميع الحقول");
    }
  }

  TextEditingController activityNameController = TextEditingController();
  TextEditingController activityDetailsController = TextEditingController();

  @override
  void dispose() {
    activityNameController.dispose();
    activityDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إضافة نشاط",
      child: BlocConsumer<CampaignDashbaordCubit, CampaignDashboardState>(
        builder: (context, state) {
          if (state is CampaignDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CampaignDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.error);
          } else {
            return Column(
              children: [
                const TitleWidget(title: "صورة النشاط"),
                Spaces.space5,
                const ChooseImageWidget(),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  controller: activityNameController,
                  label: "اسم النشاط",
                  hintText: "ادخل اسم النشاط",
                ),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  maxLines: 5,
                  controller: activityDetailsController,
                  label: "تفاصيل النشاط",
                  hintText: "ادخل تفاصيل النشاط",
                ),
                Spaces.inSectionSpace20,
                ChooseMemberWidgetAdmin(
                  icon: FontAwesomeIcons.one,
                  cardTitle: "مسؤول النشاط",
                  onSavedFunction: () {},
                  searchPath: BackendEndpoints.usersCollection,
                ),
                ChooseMemberWidgetAdmin(
                  icon: FontAwesomeIcons.two,
                  cardTitle: "اختر مسؤول اخر للنشاط",
                  onSavedFunction: () {},
                  searchPath: BackendEndpoints.usersCollection,
                  userNumber: 2,
                ),
                Spaces.sectionsSpace40,
                CustomButtonAdmin(
                  text: "حفظ",
                  onPressed: () {
                    addActivityFunction();
                  },
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CampaignDashboardEventAddedState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تمت اضافة النشاط بنجاح",
              isSuccessMessage: true,
            );
            (context).pop();
          } else if (state is CampaignDashboardErrorState) {
            Helpers.showSnackBar(
              context,
              "فشلت العملية",
              isFailureMessage: true,
            );
          }
        },
      ),
    );
  }
}
