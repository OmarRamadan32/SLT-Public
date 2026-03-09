import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MessagesPagePendingPostsDialog extends StatelessWidget {
  const MessagesPagePendingPostsDialog({
    super.key,
    required this.onAccept,
    required this.onDecline,
  });
  final Function onAccept;
  final Function onDecline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              onDecline();
              context.pop();
            },
            child: Text(
              'حذف البوست',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          SizedBox(width: 30.w),
          TextButton(
            onPressed: () async {
              onAccept();
              context.pop(); // Close dialog
            },
            child: Text(
              'قبول البوست',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
