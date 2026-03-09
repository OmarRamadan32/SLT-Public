import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/profile_images_widget.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';
import 'package:new_slt/features/members/presentation/views/profile_page_loading_view.dart';
import 'package:new_slt/features/members/presentation/widgets/edit_profile_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserById(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ScreenWidget(
      hasDrawer: false,
      isMainScreen: false,
      child: BlocConsumer<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const ProfilePageLoadingView();
          } else if (state is UserLoadedState) {
            UserModel userModel = state.userModel;
            return Column(
              children: [
                Spaces.inSectionSpace20,
                ProfileImagesWidget(
                  isDrawer: false,
                  isCentered: true,
                  imageUrl: userModel.imageUrl,
                  backGroundImageUrl: userModel.backgroundImageUrl ?? "",
                ),
                Spaces.sectionsSpace40,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerifiedIcon(accessLevel: userModel.accessLevel!),
                    ArabicTextWidget(
                      maxLines: 1,
                      text: userModel.name,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: theme.textTheme.bodyLarge!.fontSize! + 4.sp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Align(
                  alignment: Alignment.centerRight,
                  child: ArabicTextWidget(
                    text: userModel.bio ?? "قم بوضع نبذه عنك",
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: theme.textTheme.bodySmall!.fontSize,
                    ),
                  ),
                ),

                Spaces.inSectionSpace20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ArabicTextWidget(
                      text: userModel.title,
                      style: theme.textTheme.bodyMedium,
                    ),
                    ArabicTextWidget(
                      text: "اللقب: ",
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
                Spaces.space10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ArabicTextWidget(
                      text: userModel.councilNumber.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                    ArabicTextWidget(
                      text: "المجلس: ",
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
                Spaces.space10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ArabicTextWidget(
                      text: userModel.groupNumber.toString(),
                      style: theme.textTheme.bodyMedium,
                    ),
                    ArabicTextWidget(
                      text: "المجموعة: ",
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
                const Spacer(),
                if (context.read<UserCubit>().userModel!.id == widget.userId)
                  const EditProfileButton(),
                Spaces.sectionsSpace40,
              ],
            );
          } else {
            return ErrorMessageWidget(
              message: "حدث خطاء ما",
              onRetry: () {
                context.read<UserCubit>().getUserById(widget.userId);
              },
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
