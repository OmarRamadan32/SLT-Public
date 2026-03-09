// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/features/members/presentation/cubit/members_cubit.dart';

class UpdateMemberDetailsPage extends StatefulWidget {
  const UpdateMemberDetailsPage({super.key});

  @override
  State<UpdateMemberDetailsPage> createState() =>
      _UpdateMemberDetailsPageState();
}

class _UpdateMemberDetailsPageState extends State<UpdateMemberDetailsPage> {
  Future<void> updateProfileMethod() async {
    if (nameController.text.isEmpty) {
      Helpers.showSnackBar(context, "ايوه هنادولك نقولولك ايه يعني");
    } else if (nameController.text.contains("قائد")) {
      Helpers.showSnackBar(context, "إسمك فالبطاقة قائد؟");
    } else if (nameController.text.characters.length < 5) {
      Helpers.showSnackBar(context, "يااا كل ده اسم");
    } else if (bioController.text.trim().isEmpty ||
        bioController.text.isEmpty) {
      Helpers.showSnackBar(context, "يجب ان يكون البايو غير فراغ");
    } else {
      if (nameController.text.trim() == "عمر رمضان") {
        Helpers.showSnackBar(context, "عظمة الأسم تكفي والله");
        await Future.wait([Future.delayed(const Duration(seconds: 1))]);
      }
      isLoading = true;
      final MembersCubit membersCubit = context.read<MembersCubit>();
      final UserCubit userCubit = context.read<UserCubit>();
      if (userCubit.imageFile != null) {
        Helpers.showSnackBar(context, "يتم رفع الصورة الشخصية");
        await userCubit.uploadImage(
          path: userCubit.imageFile!.path,
          folderName: BackendEndpoints.usersFolder,
        );
      }
      if (userCubit.imageFileTwo != null) {
        Helpers.showSnackBar(context, "يتم رفع صورة الغلاف");
        await userCubit.uploadImage(
          path: userCubit.imageFileTwo!.path,
          folderName: BackendEndpoints.usersFolder,
          isSecondImage: true,
        );
      }
      UserModel userModel = UserModel(
        name: nameController.text.trim(),
        imageUrl: userCubit.imageUrl ?? userCubit.userModel!.imageUrl,
        accessLevel: userCubit.userModel!.accessLevel,
        backgroundImageUrl:
            userCubit.imageUrlTwo ?? userCubit.userModel!.backgroundImageUrl,
        token: userCubit.userModel!.token,
        bio: bioController.text.trim(),
        id: userCubit.userModel!.id,
        accountType: userCubit.userModel!.accountType,
        title: userCubit.userModel!.title,
        councilNumber: userCubit.userModel!.councilNumber,
        groupNumber: userCubit.userModel!.groupNumber,
        isMainBOD: userCubit.userModel!.isMainBOD,
        isSubBOD: userCubit.userModel!.isSubBOD,
      );
      await membersCubit.updateProfileDetails(userModel: userModel);
      userCubit.userModel = userModel;
      isLoading = false;
    }
  }

  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    nameController.text = context.read<UserCubit>().userModel!.name;
    bioController.text = context.read<UserCubit>().userModel!.bio!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserCubit userCubit = context.read<UserCubit>();
    return ScreenWidget(
      hasDrawer: false,
      isMainScreen: false,
      child: BlocListener<MembersCubit, MembersState>(
        listener: (context, state) {
          if (state is MembersErrorState) {
            Helpers.showSnackBar(
              context,
              state.errorMessage,
              isFailureMessage: true,
            );
            userCubit.reset();
            userCubit.getUserById(userCubit.userModel!.id!);
            context.pop();
          }
          if (state is MembersLoadingState) {
            isLoading = true;
          }
          if (state is MembersSuccessState) {
            isLoading = false;
            Helpers.showSnackBar(
              context,
              "تم التحديث بنجاح",
              isSuccessMessage: true,
            );
            userCubit.reset();
            userCubit.getUserById(userCubit.userModel!.id!);
            context.pop();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Spaces.inSectionSpace20,
              const TitleWidget(title: "صورة الغلاف"),
              Spaces.space5,
              ChooseImageWidget(
                isSecondaryImage: true,
                initialImage:
                    context.read<UserCubit>().userModel!.backgroundImageUrl,
              ),
              Spaces.inSectionSpace20,
              const TitleWidget(title: "الصورة الشخصية", isCentered: true),
              Spaces.space5,
              ChooseImageWidget(
                isCircular: true,
                initialImage: userCubit.userModel!.imageUrl,
              ),

              Spaces.inSectionSpace20,
              CustomTextFieldAdmin(
                controller: nameController,
                hintText: "ادخل اسمك",
                label: "الاسم",
              ),
              Spaces.inSectionSpace20,
              CustomTextFieldAdmin(
                maxLines: 3,
                controller: bioController,
                hintText: "ادخل البايو",
                label: "البايو",
              ),
              Spaces.sectionsSpace40,
              CustomButtonAdmin(
                isLoading: isLoading,
                onPressed: () {
                  setState(() {
                    updateProfileMethod();
                  });
                },
                text: "حفظ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
