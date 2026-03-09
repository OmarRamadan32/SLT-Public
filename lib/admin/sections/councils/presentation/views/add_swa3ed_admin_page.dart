import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class AddSwa3edAdminPage extends StatelessWidget {
  const AddSwa3edAdminPage({super.key});

  void addSwa3edFunction(BuildContext context) async {
    CouncilDashboardCubit councilCubit = context.read<CouncilDashboardCubit>();
    UserCubit userCubit = context.read<UserCubit>();
    if (userCubit.selectedUser != null &&
        userCubit.selectedUserTwo != null &&
        userCubit.imageFile != null) {
      Helpers.showSnackBar(context, "يتم رفع صورة السواعد أولا قم بالنتظار");
      await userCubit.uploadImage(
        folderName: councilCubit.council!.councilNumber.toString(),
        path: userCubit.imageFile!.path,
      );
      Swa3edModel swa3edModel = Swa3edModel(
        councilNumber: councilCubit.council!.councilNumber,
        swa3edImage: userCubit.imageUrl!,
        swa3edMembers: [],
        swa3edLeaderName: userCubit.selectedUser!.name,
        swa3edLeaderTwoName: userCubit.selectedUserTwo!.name,
        swa3edLeaderId: userCubit.selectedUser!.id!,
        swa3edLeaderTwoId: userCubit.selectedUserTwo!.id!,
      );
      await councilCubit.addSwa3ed(swa3edModel: swa3edModel);
    } else {
      Helpers.showSnackBar(context, "من فضلك ادخل جميع البيانات");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إضافة السواعد",
      child: BlocConsumer<CouncilDashboardCubit, CouncilDashboardState>(
        builder: (context, state) {
          if (state is CouncilDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CouncilDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.message);
          } else {
            return Column(
              children: [
                const TitleWidget(title: "اختر صوة السواعد"),
                Spaces.space5,
                const ChooseImageWidget(),
                Spaces.inSectionSpace20,
                ChooseMemberWidgetAdmin(
                  icon: FontAwesomeIcons.one,
                  cardTitle: "اختر قائد السواعد",
                  onSavedFunction: () {},
                  searchPath: BackendEndpoints.usersCollection,
                  userNumber: 1,
                ),
                ChooseMemberWidgetAdmin(
                  icon: FontAwesomeIcons.two,
                  cardTitle: "اختر مسؤولة السواعد",
                  onSavedFunction: () {},
                  searchPath: BackendEndpoints.usersCollection,
                  userNumber: 2,
                ),

                Spaces.sectionsSpace60,
                CustomButtonAdmin(
                  text: "حفظ",
                  onPressed: () {
                    addSwa3edFunction(context);
                  },
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CouncilDashboardSuccessState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تم اضافة السواعد بنجاح",
              isSuccessMessage: true,
            );
            Navigator.pop(context);
          }
          if (state is CouncilDashboardErrorState) {
            Helpers.showSnackBar(
              context,
              state.message,
              isFailureMessage: true,
            );
          }
        },
      ),
    );
  }
}
