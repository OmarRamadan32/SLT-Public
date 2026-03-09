import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_dialog.dart';

class CommentItemOptions extends StatefulWidget {
  const CommentItemOptions({
    super.key,
    required this.commentId,
    required this.postId,
    required this.oldCommentText,
    required this.updateComment,
    required this.deleteComment,
    required this.isCommentAuthor,
  });
  final String commentId;
  final String postId;
  final String oldCommentText;
  final Function(String newCommentText) updateComment;
  final Function() deleteComment;
  final bool isCommentAuthor;

  @override
  State<CommentItemOptions> createState() => _CommentItemOptionsState();
}

class _CommentItemOptionsState extends State<CommentItemOptions> {
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    commentController.text = widget.oldCommentText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        widget.isCommentAuthor == true
            ? Expanded(
              child: GestureDetector(
                onTap: () {
                  context.pop();
                  Helpers.showBottomSheetMethod(
                    context: context,
                    child: Container(
                      height: 500.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),

                      child: Column(
                        children: [
                          // TextField
                          Spaces.space5,
                          CustomTextFieldAdmin(
                            maxLines: 3,
                            controller: commentController,
                            label: "تعديل التعليق",
                          ),
                          Spaces.inSectionSpace20,
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 50.w,
                              ),
                              backgroundColor:
                                  theme
                                      .bottomNavigationBarTheme
                                      .backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: () {
                              if (commentController.text.trim().isNotEmpty) {
                                widget.updateComment(commentController.text);
                              } else {}
                            },
                            child: ArabicTextWidget(
                              text: "تأكيد",
                              style: theme.textTheme.titleMedium!.copyWith(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ArabicTextWidget(
                        text: "تعديل",
                        style: theme.textTheme.bodyLarge!.copyWith(),
                      ),
                      Icon(Icons.edit, color: theme.textTheme.bodyLarge!.color),
                    ],
                  ),
                ),
              ),
            )
            : Container(),
        const SizedBox(width: 20),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Helpers.showDialogMethod(
                context,
                dialogTitle: "تأكيد الحذف",
                actionsWidget: CommentItemDialog(
                  onDone: () {
                    context.pop();
                    widget.deleteComment();
                  },
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ArabicTextWidget(
                    text: "حذف",
                    style: theme.textTheme.bodyLarge!.copyWith(),
                  ),
                  Icon(Icons.delete, color: theme.textTheme.bodyLarge!.color),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
