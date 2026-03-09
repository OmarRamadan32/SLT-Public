import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/widgets/choose_multiple_images_section.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/posts/presentation/cubit/posts_dashboard_cubit.dart';

class AddPostAdminPage extends StatefulWidget {
  const AddPostAdminPage({super.key});

  @override
  State<AddPostAdminPage> createState() => _AddPostAdminPageState();
}

class _AddPostAdminPageState extends State<AddPostAdminPage> {
  void addPostButtonFunction(BuildContext context) async {
    var postDashCubit = context.read<PostsDashboardCubit>();
    UserCubit userCubit = context.read<UserCubit>();
    if (userCubit.imageFiles.isNotEmpty) {
      Helpers.showSnackBar(context, "يتم رفع الصور اولا");
      await userCubit.uploadMultipleImages(folderName: 'posts');
    }
    PostModel postModel = PostModel(
      postImages: userCubit.imageUrls,
      postAuthorName: userCubit.userModel!.name,
      postAuthorId: userCubit.userModel!.id!,
      postContent: postContentController.text,
      isSpecialPost: false,
      pending: userCubit.userModel!.accessLevel! >= 2 ? false : true,
      postDate: DateTime.now(),
    );
    await postDashCubit.addPost(postModel: postModel);
    userCubit.reset();
  }

  TextEditingController postContentController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    postContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsDashboardCubit, PostsDashboardState>(
      listener: (context, state) {
        if (state is PostsDashboardSuccessState) {
          final int userAccessLevel =
              context.read<UserCubit>().getUserAccessLevel();
          formKey.currentState!.reset();
          autovalidateMode = AutovalidateMode.disabled;
          Helpers.showSnackBar(
            context,
            userAccessLevel >= 2
                ? "تم اضافة البوست بنجاح"
                : "تم إضافة البوست بنجاح وسيتم عرضه بعد الموافقة عليه",
            isSuccessMessage: true,
          );
          Navigator.pop(context);
        } else if (state is PostsDashboardFailureState) {
          Helpers.showSnackBar(
            context,
            state.errorMessage,
            isFailureMessage: true,
          );
        }
      },
      builder: (context, state) {
        return DashboardScreenWidget(
          appBarTitle: "اضافة بوست",
          child: Column(
            children: [
              Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: CustomTextFieldAdmin(
                  controller: postContentController,
                  validator:
                      (p0) =>
                          p0!.isEmpty
                              ? "يجب ان يكون محتوي البوست غير فارغ"
                              : null,

                  label: "محتوي البوست",
                  maxLines: 10,
                  hintText: "اكتب ما تشاء",
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              Spaces.inSectionSpace20,
              const ChooseMultipleImagesSection(),
              Spaces.sectionsSpace60,
              CustomButtonAdmin(
                isLoading: state is PostsDashboardLoadingState,
                text: "حفظ",
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    addPostButtonFunction(context);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
