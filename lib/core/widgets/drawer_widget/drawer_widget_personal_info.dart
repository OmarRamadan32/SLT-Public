import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/profile_images_widget.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';

class DrawerWidgetPersonalInfo extends StatelessWidget {
  const DrawerWidgetPersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileImagesWidget(
          isDrawer: true,
          backGroundImageUrl:
              context.read<UserCubit>().userModel!.backgroundImageUrl ?? "",
          isCentered: false,
          imageUrl: context.read<UserCubit>().userModel!.imageUrl,
        ),

        Padding(
          padding: EdgeInsets.only(top: 10.h, left: 2.w, right: 2.w),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.center,
              child: Row(
                children: [
                  VerifiedIcon(
                    accessLevel:
                        context.read<UserCubit>().userModel!.accessLevel!,
                  ),
                  ArabicTextWidget(
                    text: context.read<UserCubit>().userModel!.name,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontSize: theme.textTheme.bodyLarge!.fontSize! + 2.5.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
