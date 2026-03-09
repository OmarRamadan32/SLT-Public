import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:new_slt/features/auth/presentation/widgets/choose_drop_down_widget.dart';

class RegisterMemberDetailsBoxesSection extends StatelessWidget {
  const RegisterMemberDetailsBoxesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: ArabicTextWidget(
            text: "معلومات عضو الفريق",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Spaces.inSectionSpace20,
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
            child: Column(
              children: [
                ChooseDropdownBoxWidget(
                  label: "المجلس",
                  selectedValue:
                      context
                          .read<AuthCubit>()
                          .userModel
                          .councilNumber
                          .toString(),
                  items: [
                    ...List.generate(50, (index) => (index + 1).toString()),
                  ],
                  onSelected: (value) {
                    context.read<AuthCubit>().setCouncilNumber(
                      int.parse(value),
                    );
                  },
                ),
                Spaces.inSectionSpace20,
                ChooseDropdownBoxWidget(
                  label: "المجموعة",
                  selectedValue:
                      context
                          .read<AuthCubit>()
                          .userModel
                          .groupNumber
                          .toString(),

                  items: [
                    ...List.generate(5, (index) => (index + 1).toString()),
                  ],
                  onSelected: (value) {
                    context.read<AuthCubit>().setGroupNumber(int.parse(value));
                  },
                ),
                Spaces.inSectionSpace20,
                ChooseDropdownBoxWidget(
                  label: "اللقب",
                  selectedValue: context.read<AuthCubit>().userModel.title,
                  items: ["عضو", "قائد", "رائد", "انسة"],
                  onSelected: (value) {
                    context.read<AuthCubit>().setTitle(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
