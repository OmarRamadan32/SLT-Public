import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';

class UpdateActivityDetailsAdminPage extends StatefulWidget {
  const UpdateActivityDetailsAdminPage({super.key, required this.activity});
  final ActivityModel? activity;

  @override
  State<UpdateActivityDetailsAdminPage> createState() =>
      _UpdateActivityDetailsAdminPageState();
}

class _UpdateActivityDetailsAdminPageState
    extends State<UpdateActivityDetailsAdminPage> {
  @override
  void initState() {
    activityNameController.text = widget.activity!.activityName;
    activityDetailsController.text = widget.activity!.activityDescription;
    super.initState();
  }

  Future<void> updateActivityFunction() async {
    UserCubit userCubit = context.read<UserCubit>();
    CampaignDashbaordCubit campaignDashbaordCubit =
        context.read<CampaignDashbaordCubit>();
    if (activityNameController.text.isNotEmpty &&
        activityDetailsController.text.isNotEmpty) {
      if (userCubit.imageFile != null) {
        Helpers.showSnackBar(context, "جاري رفع صورة النشاط");
        await userCubit.uploadImage(
          path: userCubit.imageFile!.path,
          folderName:
              '${BackendEndpoints.campaignsFolder}/${campaignDashbaordCubit.campaign!.campaignName} ${campaignDashbaordCubit.campaign!.campaignNumber}}',
        );
      }

      ActivityModel activityModel = ActivityModel.forUpdate(
        activityName: activityNameController.text,
        activityDescription: activityDetailsController.text,
        activityImage: userCubit.imageUrl ?? widget.activity!.activityImage,
      );
      await campaignDashbaordCubit.updateActivityDetails(
        activityModel: activityModel,
      );
    } else {
      Helpers.showSnackBar(context, "ادخل جميع البيانات");
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
      appBarTitle: "تحديث بيانات النشاط",
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
                ChooseImageWidget(initialImage: widget.activity!.activityImage),
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
                Spaces.sectionsSpace40,
                CustomButtonAdmin(
                  text: "حفظ",
                  onPressed: () {
                    updateActivityFunction();
                  },
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CampaignDashboardErrorState) {
            Helpers.showSnackBar(context, state.error, isFailureMessage: true);
          }
          if (state is CampaignDashboardSuccessState) {
            Helpers.showSnackBar(
              context,
              "تم تحديث بيانات النشاط بنجاح",
              isSuccessMessage: true,
            );
            context.pop();
          }
        },
      ),
    );
  }
}
