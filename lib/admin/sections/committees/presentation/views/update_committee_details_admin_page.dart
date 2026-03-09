import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/committees/presentation/cubit/committee_dashboard_cubit.dart';

class UpdateCommitteeDetailsAdminPage extends StatefulWidget {
  const UpdateCommitteeDetailsAdminPage({
    super.key,
    required this.committeeModel,
  });
  final CommitteeModel committeeModel;

  @override
  State<UpdateCommitteeDetailsAdminPage> createState() =>
      _UpdateCommitteeDetailsAdminPageState();
}

class _UpdateCommitteeDetailsAdminPageState
    extends State<UpdateCommitteeDetailsAdminPage> {
  Future<void> updateCommitteeFunction() async {
    // create an instance from user and committee admin cubits
    UserCubit userCubit = context.read<UserCubit>();
    CommitteeDashboardCubit committeeDashboardCubit =
        context.read<CommitteeDashboardCubit>();
    // check if the user choosed a new image then upload it
    if (userCubit.imageFile != null) {
      Helpers.showSnackBar(context, "يتم رفع الصورة الجديدة");
      // upload the new image
      await userCubit.uploadImage(
        path: userCubit.imageFile!.path,
        folderName: BackendEndpoints.committeesFolder,
      );
    }
    // get the new committee details
    String committeeName = nameController.text;
    String committeeDescription = descriptionController.text;
    String? newCommitteeImageurl = userCubit.imageUrl;
    CommitteeModel committeeModel = CommitteeModel.forUpdate(
      committeeName: committeeName,
      committeeImage:
          newCommitteeImageurl ?? widget.committeeModel.committeeImage,
      committeeDescription: committeeDescription,
    );
    // update the committee Details
    await committeeDashboardCubit.updateCommitteeDetails(
      committeeModel: committeeModel,
      committeeId: widget.committeeModel.id!,
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<UserCubit>().reset();
    nameController.text = widget.committeeModel.committeeName;
    descriptionController.text = widget.committeeModel.committeeDescription;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "تغيير تفاصيل اللجنة",
      child: BlocConsumer<CommitteeDashboardCubit, CommitteeDashboardState>(
        builder: (context, state) {
          if (state is CommitteeDashboardLoadingState) {
            return const LoadingWidget(
              isCentered: true,
              message: "يتم تحديث تفاصيل اللجنة...",
            );
          } else if (state is CommitteeDashboardErrorState) {
            return ErrorMessageWidget(message: state.message);
          } else {
            return Column(
              children: [
                // change committee image
                const TitleWidget(title: "تغيير صورة اللجنة"),
                Spaces.space5,
                ChooseImageWidget(
                  initialImage: widget.committeeModel.committeeImage,
                ),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  label: "اسم اللجنة",
                  controller: nameController,
                ),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  label: "وصف اللجنة",
                  maxLines: 5,
                  controller: descriptionController,
                ),
                Spaces.sectionsSpace40,
                CustomButtonAdmin(
                  text: "حفظ",
                  onPressed: () {
                    updateCommitteeFunction();
                  },
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CommitteeDashboardSuccessState) {
            Helpers.showSnackBar(context, "تم تحديث تفاصيل اللجنة بنجاح");
            context.pushReplacement(AppRouter.kCommitteesAdminPage);
          } else if (state is CommitteeDashboardErrorState) {
            Helpers.showSnackBar(context, state.message);
          }
        },
      ),
    );
  }
}
