import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/image_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';

class ChooseMultipleImagesSection extends StatelessWidget {
  const ChooseMultipleImagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<File> selectedImages = context.read<UserCubit>().imageFiles;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ListTile(
            onTap: () {
              context.read<UserCubit>().pickMultipleImages();
            },

            leading: const Icon(Icons.image),
            title: ArabicTextWidget(
              text: "اختيار صور",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (selectedImages.isNotEmpty) {
              return Column(
                children: [
                  SmallNoteWidget(
                    content:
                        "الحد المتبقي لعدد الصور : ${5 - selectedImages.length}",
                  ),
                  Spaces.space10,
                  SizedBox(
                    height: 150.h,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: selectedImages.length,
                            itemBuilder: (context, index) {
                              return ImageWidget(image: selectedImages[index]);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SmallNoteWidget(
                content: "الحد الاقصي لعدد الصور: 5",
              );
            }
          },
        ),
      ],
    );
  }
}
