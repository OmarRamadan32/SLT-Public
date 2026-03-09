import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/global_cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class DetailsRowWidget extends StatelessWidget {
  const DetailsRowWidget({
    super.key,
    required this.cardsCount,
    required this.titles,
    required this.subTitles,
    this.flexes,
    required this.primaryColorCount,
  });

  final int cardsCount;
  final List<String> titles;
  final List<String> subTitles;
  final List<int>? flexes;
  final int primaryColorCount;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: List.generate(cardsCount, (index) {
        final isPrimary =
            primaryColorCount > 0 && index >= cardsCount - primaryColorCount;
        final color =
            isPrimary
                ? theme.primaryColor
                : theme.bottomNavigationBarTheme.backgroundColor!;
        final textColor =
            isPrimary
                ? theme.bottomNavigationBarTheme.backgroundColor!
                : theme.primaryColor;
        final subTitleColor =
            context.read<AppThemeCubit>().state == ThemeMode.dark
                ? Colors.white
                : Colors.black;

        return Expanded(
          flex: flexes != null && flexes!.length > index ? flexes![index] : 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.9),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.5.h),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title
                  ArabicTextWidget(
                    text: titles.length > index ? titles[index] : '',
                    maxLines: 1,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: textColor,
                    ),
                  ),
                  // subtitle
                  ArabicTextWidget(
                    text: subTitles.length > index ? subTitles[index] : '',
                    maxLines: 1,
                    style: theme.textTheme.labelSmall!.copyWith(
                      color: subTitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
