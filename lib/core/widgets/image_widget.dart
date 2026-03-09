import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.image});
  final File image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 150.h,
          width: 150.w,
          child: Image.file(image, fit: BoxFit.cover),
        ),
        Positioned(
          top: 15,
          right: 15,
          child: GestureDetector(
            onTap: () {
              context.read<UserCubit>().excludeImage(image);
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.black38,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, color: Colors.white, size: 17.sp),
            ),
          ),
        ),
      ],
    );
  }
}
