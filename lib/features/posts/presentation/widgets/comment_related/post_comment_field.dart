import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/admin/data/models/choose_members_page_model.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/choosed_users_section.dart';

class PostCommentField extends StatefulWidget {
  const PostCommentField({super.key, required this.onTap});

  @override
  State<PostCommentField> createState() => _PostCommentFieldState();

  final void Function(String comment) onTap;
}

TextEditingController commentController = TextEditingController();

class _PostCommentFieldState extends State<PostCommentField> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (commentController.text.trim().isNotEmpty) {
                    widget.onTap(commentController.text);
                    commentController.clear();
                  } else {
                    Helpers.showSnackBar(
                      context,
                      "لا يمكنك وضع تعليق فارغ",
                      isFailureMessage: true,
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(14.r),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.bottomNavigationBarTheme.backgroundColor,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.solidPaperPlane,
                    color: theme.primaryColor,
                    size: 25.sp,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 13),
            GestureDetector(
              onTap: () {
                context.push(
                  "${AppRouter.kChooseMultibleMembersPage}?path=${BackendEndpoints.usersCollection}",
                  extra: ChooseMembersPageModel(onSaved: () {}),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40.h),
                padding: EdgeInsets.all(10.r),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.bottomNavigationBarTheme.backgroundColor,
                ),
                child: FaIcon(
                  FontAwesomeIcons.at,
                  color: theme.primaryColor,
                  size: 20.sp,
                ),
              ),
            ),
            const SizedBox(width: 13),
            Expanded(
              flex: 5,
              child: SizedBox(
                child: TextField(
                  controller: commentController,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                  cursorColor: theme.primaryColor,
                  enabled: true,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    hint: ArabicTextWidget(
                      text: "كتابة تعليق...",
                      style: theme.textTheme.labelMedium,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    fillColor: theme.bottomNavigationBarTheme.backgroundColor,
                    filled: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        Spaces.space10,
        const ChoosedUsersSection(),
      ],
    );
  }
}
