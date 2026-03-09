import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/widgets/choose_multiple_images_section.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/posts/presentation/cubit/posts_dashboard_cubit.dart';

class AddSpecialPostAdminPage extends StatefulWidget {
  const AddSpecialPostAdminPage({super.key});

  @override
  State<AddSpecialPostAdminPage> createState() =>
      _AddSpecialPostAdminPageState();
}

class _AddSpecialPostAdminPageState extends State<AddSpecialPostAdminPage> {
  void addSpecialPost(BuildContext context) async {
    String postTitle = postTitleController.text.trim();
    String postContent = postContentController.text.trim();
    String postNote = postNoteController.text.trim();
    UserCubit userCubit = context.read<UserCubit>();
    int postMaxRegister = int.parse(postMaxRegisterController.text.trim());
    var postDashCubit = context.read<PostsDashboardCubit>();
    final int userAccessLevel = context.read<UserCubit>().getUserAccessLevel();

    if (userCubit.imageFiles.isNotEmpty) {
      Helpers.showSnackBar(context, "يتم رفع الصور اولا");
      await userCubit.uploadMultipleImages(folderName: 'posts');
    }

    PostModel postModel = PostModel(
      postImages: userCubit.imageUrls,
      postAuthorName: userCubit.userModel!.name,
      postAuthorAccessLevel: userCubit.userModel!.accessLevel!,
      postAuthorId: userCubit.userModel!.id!,
      postContent: postContent,
      isSpecialPost: true,
      pending: userAccessLevel >= 2 ? false : true,
      specialPostSigners: [],
      postDate: DateTime.now(),
      specialPostSignersMaxCount: postMaxRegister,
      specialpostNote: postNote,
      postTitle: postTitle,
    );
    await postDashCubit.addPost(postModel: postModel);
    userCubit.reset();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postContentController = TextEditingController();
  TextEditingController postNoteController = TextEditingController();
  TextEditingController postMaxRegisterController = TextEditingController();

  @override
  void dispose() {
    postTitleController.dispose();
    postContentController.dispose();
    postNoteController.dispose();
    postMaxRegisterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "اضافة بوست بخاصية التسجيل ",
      child: BlocConsumer<PostsDashboardCubit, PostsDashboardState>(
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
            context.pop();
          } else if (state is PostsDashboardFailureState) {
            Helpers.showSnackBar(
              context,
              state.errorMessage,
              isFailureMessage: true,
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextFieldAdmin(
                  controller: postTitleController,
                  validator:
                      (p0) => p0!.isEmpty ? "يرجي كتابة عنوان البوست" : null,
                  label: "عنوان البوست",
                  maxLines: 1,
                  hintText: "اكتب نبذه عن محتوي البوست",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.multiline,
                ),
                const SmallNoteWidget(
                  content: "سيظهر عنوان البوست في الصفحة الخاصة بالبوست فقط",
                ),
                Spaces.sectionsSpace40,

                CustomTextFieldAdmin(
                  controller: postContentController,
                  validator:
                      (p0) => p0!.isEmpty ? "يرجي كتابة محتوي البوست" : null,
                  label: "محتوي البوست",
                  maxLines: 10,
                  hintText: "اكتب ما تشاء",
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                Spaces.sectionsSpace40,
                CustomTextFieldAdmin(
                  controller: postNoteController,
                  validator: (p0) {
                    return null;
                  },
                  label: "اضافة ملاحظة",
                  hintText: "مثال: موعد انتهاء التسجيل. (اختياري)",
                ),
                const SmallNoteWidget(content: "ستظهر الملاحظة أسفل البوست"),
                Spaces.sectionsSpace40,
                SizedBox(
                  width: 250.w,
                  child: CustomTextFieldAdmin(
                    controller: postMaxRegisterController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    validator: (p0) {
                      if (int.tryParse(p0!) == null && p0.isNotEmpty) {
                        return "انت شايف ان ده رقم يعني !!";
                      } else if (p0.isEmpty) {
                        return "يرجي كتابة عدد التسجيل";
                      } else if (int.parse(p0) == 0) {
                        return "انت عامله لنفسك يعني ولا ايه ؟";
                      } else {
                        return null;
                      }
                    },
                    label: "الحد الاقصي لعدد التسجيل",
                    hintText: "000",
                  ),
                ),
                Spaces.space10,
                SizedBox(
                  width: 100.w,
                  child: Divider(
                    thickness: 0.7,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Spaces.inSectionSpace20,
                const DetailsBoxWidget(
                  content: "الرجاء حذف البوست بعد انتهاء التسجيل",
                ),
                Spaces.sectionsSpace40,
                const ChooseMultipleImagesSection(),
                Spaces.sectionsSpace60,
                CustomButtonAdmin(
                  isLoading: state is PostsDashboardLoadingState,
                  text: "حفظ",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      addSpecialPost(context);
                    } else {
                      autovalidateMode = AutovalidateMode.always;
                    }
                  },
                ),
                Spaces.inSectionSpace20,
              ],
            ),
          );
        },
      ),
    );
  }
}
