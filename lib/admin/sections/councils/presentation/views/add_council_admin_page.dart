import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class AddCouncilAdminPage extends StatefulWidget {
  const AddCouncilAdminPage({super.key});

  @override
  State<AddCouncilAdminPage> createState() => _AddCouncilAdminPageState();
}

class _AddCouncilAdminPageState extends State<AddCouncilAdminPage> {
  Future<void> addCouncilFunction() async {
    UserCubit userCubit = context.read<UserCubit>();
    CouncilDashboardCubit councilDashboardCubit =
        context.read<CouncilDashboardCubit>();
    if (councilNumberController.text.isNotEmpty &&
        userCubit.selectedUser != null &&
        userCubit.imageFile != null) {
      Helpers.showSnackBar(context, "يتم رفع صورة المجلس أولا قم بالنتظار");
      await userCubit.uploadImage(
        path: userCubit.imageFile!.path,
        folderName:
            "${BackendEndpoints.councilFolder}/${councilNumberController.text}",
      );
      CouncilModel councilModel = CouncilModel(
        councilLeaderId: userCubit.selectedUser!.id!,
        councilNewMembersCount: 0,
        isCurrent: true,
        councilLeaderName: userCubit.selectedUser!.name,
        councilLeaderTwoName: userCubit.selectedUserTwo?.name,
        councilLeaderTwoId: userCubit.selectedUserTwo?.id,
        councilNumber: int.parse(councilNumberController.text),
        councilImage: userCubit.imageUrl!,
        councilMembersModel: [],
      );
      await councilDashboardCubit.addCouncil(councilModel: councilModel);
    } else {
      Helpers.showSnackBar(context, "من فضلك ادخل جميع البيانات");
    }
  }

  TextEditingController councilNumberController = TextEditingController();

  @override
  void dispose() {
    councilNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إضافة مجلس",
      child: Column(
        children: [
          BlocConsumer<CouncilDashboardCubit, CouncilDashboardState>(
            builder: (context, state) {
              if (state is CouncilDashboardLoadingState) {
                return const LoadingWidget(isCentered: true);
              } else if (state is CouncilDashboardErrorState) {
                return ErrorMessageWidget(
                  isCentered: true,
                  message: state.message,
                );
              } else {
                return Column(
                  children: [
                    const TitleWidget(title: "اختر صورة المجلس"),
                    Spaces.space5,
                    const ChooseImageWidget(),
                    Spaces.sectionsSpace40,
                    SizedBox(
                      width: 150.w,
                      child: CustomTextFieldAdmin(
                        label: "رقم المجلس",
                        controller: councilNumberController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spaces.sectionsSpace40,
                    ChooseMemberWidgetAdmin(
                      icon: FontAwesomeIcons.userPen,
                      cardTitle: "قائد المجلس",
                      onSavedFunction: () {},
                      searchPath: BackendEndpoints.usersCollection,
                    ),
                    ChooseMemberWidgetAdmin(
                      icon: FontAwesomeIcons.userPen,
                      cardTitle: "مسؤول اخر للمجلس (اختياري)",
                      onSavedFunction: () {},
                      userNumber: 2,
                      searchPath: BackendEndpoints.usersCollection,
                    ),
                    Spaces.sectionsSpace60,
                    CustomButtonAdmin(
                      onPressed: () {
                        addCouncilFunction();
                      },
                      text: "حفظ",
                    ),
                  ],
                );
              }
            },
            listener: (context, state) {
              if (state is CouncilDashboardCouncilAddedState) {
                context.read<UserCubit>().reset();
                Helpers.showSnackBar(
                  context,
                  "تمت إضافة المجلس بنجاح",
                  isSuccessMessage: true,
                );
                context.pop();
              } else if (state is CouncilDashboardErrorState) {
                context.read<UserCubit>().reset();
                Helpers.showSnackBar(
                  context,
                  state.message,
                  isFailureMessage: true,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
