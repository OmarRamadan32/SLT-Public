import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/committees/presentation/cubit/committee_dashboard_cubit.dart';

class AddCommitteeAdminPage extends StatefulWidget {
  const AddCommitteeAdminPage({super.key});

  @override
  State<AddCommitteeAdminPage> createState() => _AddCommitteeAdminPageState();
}

class _AddCommitteeAdminPageState extends State<AddCommitteeAdminPage> {
  Future<void> addCommitteeFunction() async {
    UserCubit userCubit = context.read<UserCubit>();
    CommitteeDashboardCubit committeeDashboardCubit =
        context.read<CommitteeDashboardCubit>();
    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        context.read<UserCubit>().selectedUser != null &&
        context.read<UserCubit>().imageFile != null) {
      Helpers.showSnackBar(context, "جاري الانشاء");
      await userCubit.uploadImage(
        path: userCubit.imageFile!.path,
        folderName: BackendEndpoints.committeesFolder,
      );
      CommitteeModel committeeModel = CommitteeModel(
        committeeMembers: [],
        committeeLeaderName: userCubit.selectedUser!.name,
        committeeName: nameController.text,
        committeeDescription: descriptionController.text,
        committeeImage: userCubit.imageUrl!,
        committeeLeaderId: userCubit.selectedUser!.id!,
      );
      await committeeDashboardCubit.addCommittee(
        committeeModel: committeeModel,
      );
    } else {
      Helpers.showSnackBar(context, "ادخل جميع البيانات");
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    context.read<UserCubit>().reset();
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
      appBarTitle: "إضافة لجنة",
      child: BlocConsumer<CommitteeDashboardCubit, CommitteeDashboardState>(
        builder: (context, state) {
          if (state is CommitteeDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CommitteeDashboardErrorState) {
            return ErrorMessageWidget(message: state.message);
          } else {
            return Column(
              children: [
                const TitleWidget(
                  title: "صورة اللجنة",
                  subtitle: "إضغط للاختيار",
                ),
                Spaces.space5,
                const ChooseImageWidget(),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  label: "اسم اللجنة",
                  controller: nameController,
                  hintText: "ادخل اسم اللجنة",
                ),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  label: "وصف اللجنة",
                  controller: descriptionController,
                  hintText: "ادخل وصف اللجنة",
                  maxLines: 5,
                ),
                Spaces.inSectionSpace20,
                const TitleWidget(title: "مسؤول اللجنة"),
                ChooseMemberWidgetAdmin(
                  cardTitle: "قم باختيار المسؤول",
                  onSavedFunction: () {},
                  searchPath: BackendEndpoints.usersCollection,
                ),
                Spaces.sectionsSpace40,
                const DetailsBoxWidget(
                  content:
                      "يمكنك إضافة اعضاء اللجنة بعد إضافة اللجنة نفسها من إعدادات اللجان",
                ),
                Spaces.sectionsSpace40,
                CustomButtonAdmin(
                  onPressed: () {
                    addCommitteeFunction();
                  },
                  text: "إضافة",
                ),
                Spaces.inSectionSpace20,
              ],
            );
          }
        },
        listener: (context, state) {
          UserCubit userCubit = context.read<UserCubit>();
          if (state is CommitteeDashboardErrorState) {
            Helpers.showSnackBar(
              context,
              state.message,
              isFailureMessage: true,
            );
            userCubit.reset();
          }
          if (state is CommitteeDashboardCommitteeAddedState) {
            context.pop();
            Helpers.showSnackBar(
              context,
              "تم اضافة اللجنة بنجاح",
              isSuccessMessage: true,
            );
            userCubit.reset();
          }
        },
      ),
    );
  }
}
