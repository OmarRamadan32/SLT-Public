import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/widgets/select_campaign_type_widget_admin.dart';

class AddCampaignAdminPage extends StatefulWidget {
  const AddCampaignAdminPage({super.key});

  @override
  State<AddCampaignAdminPage> createState() => _AddCampaignAdminPageState();
}

class _AddCampaignAdminPageState extends State<AddCampaignAdminPage> {
  Future<void> addCampaignFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    CampaignDashbaordCubit campaignDashbaordCubit =
        context.read<CampaignDashbaordCubit>();
    if (userCubit.imageFile != null &&
        campaignNumberController.text.isNotEmpty &&
        userCubit.selectedUser != null) {
      final String imageFolderPath =
          '${BackendEndpoints.campaignsFolder}/$campaignType ${campaignNumberController.text}';
      Helpers.showSnackBar(context, "جاري رفع صورة الحملة أولا");
      try {
        await userCubit.uploadImage(
          path: userCubit.imageFile!.path,
          folderName: imageFolderPath,
        );
        CampaignModel campaignModel = CampaignModel(
          campaignLeaderName: userCubit.selectedUser!.name,
          campaignName: campaignType,
          campaignImage: userCubit.imageUrl!,
          campaignNumber: int.parse(campaignNumberController.text),
          campaignLeaderId: userCubit.selectedUser!.id!,
          campaignLeaderTwoId: userCubit.selectedUserTwo?.id,
          campaignLeaderTwoName: userCubit.selectedUserTwo?.name,
          isCurrent: true,
          campaignMembersModels: [],
        );
        await campaignDashbaordCubit.addCampaign(campaignModel: campaignModel);
      } catch (e) {
        Helpers.showSnackBar(context, "فشلت العملية");
      }
    } else {
      Helpers.showSnackBar(context, "من فضلك قم بتعبئة جميع الحقول");
    }
  }

  String campaignType = "عشان ربنا";
  TextEditingController campaignNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = context.read<UserCubit>();
    return DashboardScreenWidget(
      appBarTitle: "إضافة حملة",
      child: BlocConsumer<CampaignDashbaordCubit, CampaignDashboardState>(
        builder: (context, state) {
          if (state is CampaignDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CampaignDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.error);
          } else {
            return Column(
              children: [
                const TitleWidget(title: "إختر صورة الحملة"),
                Spaces.space5,
                const ChooseImageWidget(),
                Spaces.inSectionSpace20,
                const TitleWidget(title: "نوع الحملة"),
                SelectCampaignTypeWidgetAdmin(
                  onSelected: (value) {
                    campaignType = value;
                  },
                ),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  label: "رقم الحملة",
                  controller: campaignNumberController,
                  keyboardType: TextInputType.number,
                  // textAlign: TextAlign.center,
                  hintText: "تأكد من ان يكون رقم باللغة الانجليزيه",
                ),
                Spaces.inSectionSpace20,
                ChooseMemberWidgetAdmin(
                  icon: FontAwesomeIcons.one,
                  cardTitle: "اختر مسؤول الحملة",

                  onSavedFunction: () {},
                  searchPath: BackendEndpoints.usersCollection,
                ),
                ChooseMemberWidgetAdmin(
                  icon: FontAwesomeIcons.two,
                  cardTitle: "اختر مسؤول الحملة الثاني (اختياري)",
                  onSavedFunction: () {},
                  userNumber: 2,
                  searchPath: BackendEndpoints.usersCollection,
                ),
                Spaces.sectionsSpace40,
                const DetailsBoxWidget(
                  content:
                      "يمكنك إضافة انشطة الحملة بعد إتمام إضافة الحملة نفسها من إعدادات الحملات",
                ),
                Spaces.sectionsSpace40,
                CustomButtonAdmin(
                  onPressed: () {
                    addCampaignFunction(context);
                  },
                  text: "حفظ",
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CampaignDashboardEventAddedState) {
            userCubit.reset();
            Helpers.showSnackBar(
              context,
              "تمت إضافة الحملة بنجاح",
              isSuccessMessage: true,
            );
            context.pop();
          }
        },
      ),
    );
  }
}
