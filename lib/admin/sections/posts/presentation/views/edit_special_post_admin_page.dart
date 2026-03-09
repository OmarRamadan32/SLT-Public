import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/posts/presentation/cubit/posts_dashboard_cubit.dart';

class EditSpecialPostAdminPage extends StatefulWidget {
  const EditSpecialPostAdminPage({super.key, required this.postId});
  final String postId;

  @override
  State<EditSpecialPostAdminPage> createState() =>
      _EditSpecialPostAdminPageState();
}

class _EditSpecialPostAdminPageState extends State<EditSpecialPostAdminPage> {
  @override
  void initState() {
    context.read<PostsDashboardCubit>().getPostById(postId: widget.postId);
    super.initState();
  }

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
      appBarTitle: "تعديل بوست",
      child: BlocConsumer<PostsDashboardCubit, PostsDashboardState>(
        listener: (context, state) {
          if (state is SinglePostDashboardLoadedState) {
            postTitleController.text = state.post.postTitle!;
            postContentController.text = state.post.postContent;
            postNoteController.text = state.post.specialpostNote!;
            postMaxRegisterController.text =
                state.post.specialPostSignersMaxCount.toString();
          } else if (state is PostsDashboardFailureState) {
            Helpers.showSnackBar(
              context,
              state.errorMessage,
              isFailureMessage: true,
            );
          } else if (state is SinglePostDashboardUpdatedState) {
            Helpers.showSnackBar(
              context,
              "تم التعديل بنجاح",
              isSuccessMessage: true,
            );
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is SinglePostDashboardLoadedState) {
            return Column(
              children: [
                CustomTextFieldAdmin(
                  controller: postTitleController,
                  label: "عنوان البوست",
                  maxLines: 1,
                  hintText: "العنوان",
                ),
                Spaces.sectionsSpace40,
                CustomTextFieldAdmin(
                  controller: postContentController,
                  label: "محتوي البوست",
                  maxLines: 10,
                  hintText: "اكتب ما تشاء",
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                Spaces.sectionsSpace40,
                CustomTextFieldAdmin(
                  label: "تعديل ملاحظة",
                  controller: postNoteController,
                ),
                Spaces.sectionsSpace40,
                SizedBox(
                  width: 200.w,
                  child: CustomTextFieldAdmin(
                    controller: postMaxRegisterController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    hintText: "000",
                    label: "الحد الاقصي لعدد التسجيل",
                  ),
                ),
                const SmallNoteWidget(
                  content: "يرجي ذكر الحد الاقصي لعدد التسجيل في محتوي البوست",
                  alignment: Alignment.center,
                ),
                Spaces.sectionsSpace60,
                CustomButtonAdmin(
                  isLoading: state is PostsDashboardLoadingState,
                  text: "حفظ",
                  onPressed: () {
                    state.post.postTitle = postTitleController.text;
                    state.post.postContent = postContentController.text;
                    state.post.specialpostNote = postNoteController.text;
                    state.post.specialPostSignersMaxCount = int.parse(
                      postMaxRegisterController.text,
                    );

                    context.read<PostsDashboardCubit>().updatePost(
                      postId: state.post.postId!,
                      postModel: state.post,
                    );
                  },
                ),
              ],
            );
          } else if (state is PostsDashboardLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
