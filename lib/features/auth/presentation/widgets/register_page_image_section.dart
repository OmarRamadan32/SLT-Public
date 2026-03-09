import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class RegisterPageImageSection extends StatelessWidget {
  const RegisterPageImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final image = context.read<UserCubit>().imageFile;
        return Column(
          children: [
            const ArabicTextWidget(text: "اختر صورة"),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                context.read<UserCubit>().pickImage();
              },
              child: SizedBox(
                height: 150.r,
                width: 150.r,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000.r),
                  child:
                      image != null
                          ? Image.file(image, fit: BoxFit.cover)
                          : Container(color: Colors.grey),
                ),
              ),
            ),
            Spaces.inSectionSpace20,
            SizedBox(
              width: 200.w,
              child: Divider(
                color: Theme.of(context).primaryColor.withAlpha(150),
                thickness: 1.3,
              ),
            ),
          ],
        );
      },
    );
  }
}
