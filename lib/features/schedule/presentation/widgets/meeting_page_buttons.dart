import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/features/schedule/presentation/widgets/schedule_abs_bottomsheet.dart';

class SchedulePageButtons extends StatelessWidget {
  const SchedulePageButtons({
    super.key,
    required this.path,
    required this.docId,
  });
  final String path;
  final String docId;

  @override
  Widget build(BuildContext context) {
    final ScheduleCubit cubit = context.read<ScheduleCubit>();
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection:
          TextDirection.rtl, // This puts the first child (الحضور) on the right
      children: [
        ElevatedButton(
          onPressed: () async {
            await cubit.attsSchedule(
              path: path,
              userId: context.read<UserCubit>().userModel!.id.toString(),
              docId: docId,
            );
            await cubit.getScheduleById(path: path, docId: docId);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 12.h),
          ),
          child: Text(
            "الحضور",
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
        SizedBox(width: 50.w),
        ElevatedButton(
          onPressed: () async {
            UserModel currentUser = context.read<UserCubit>().userModel!;
           Helpers.  showBottomSheetMethod(
              context: context,
              child: ScheduleAbsBottomsheet(
                path: path,
                docId: docId,
                userModel: currentUser,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 12.h),
          ),
          child: Text("الاعتذار", style: theme.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
