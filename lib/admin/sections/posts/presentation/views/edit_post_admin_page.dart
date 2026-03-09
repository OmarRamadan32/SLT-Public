import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/posts/presentation/cubit/posts_dashboard_cubit.dart';

class EditPostAdminPage extends StatefulWidget {
  const EditPostAdminPage({super.key, required this.postId});
  final String postId;

  @override
  State<EditPostAdminPage> createState() => _EditPostAdminPageState();
}

class _EditPostAdminPageState extends State<EditPostAdminPage> {
  @override
  void initState() {
    context.read<PostsDashboardCubit>().getPostById(postId: widget.postId);
    super.initState();
  }

  final TextEditingController editPostController = TextEditingController();

  @override
  void dispose() {
    editPostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "تعديل بوست",
      child: BlocConsumer<PostsDashboardCubit, PostsDashboardState>(
        builder: (context, state) {
          if (state is SinglePostDashboardLoadedState) {
            return Column(
              children: [
                CustomTextFieldAdmin(
                  label: "محتوي البوست",
                  controller: editPostController,
                  maxLines: 10,
                  hintText: "اكتب ما تشاء",
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                Spaces.sectionsSpace60,
                CustomButtonAdmin(
                  text: "حفظ",
                  isLoading: state is PostsDashboardLoadingState,
                  onPressed: () {
                    state.post.postContent = editPostController.text;
                    context.read<PostsDashboardCubit>().updatePost(
                      postId: state.post.postId!,
                      postModel: state.post,
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        listener: (context, state) {
          if (state is PostsDashboardFailureState) {
            Helpers.showSnackBar(
              context,
              state.errorMessage,
              isFailureMessage: true,
            );
          } else if (state is SinglePostDashboardLoadedState) {
            editPostController.text = state.post.postContent;
          } else if (state is SinglePostDashboardUpdatedState) {
            Helpers.showSnackBar(
              context,
              "تم التعديل بنجاح",
              isSuccessMessage: true,
            );
            context.pushReplacement(AppRouter.kPostsAdminPage);
          }
        },
      ),
    );
  }
}
