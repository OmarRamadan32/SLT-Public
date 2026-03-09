import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';

class GroupNameAndImageSection extends StatelessWidget {
  const GroupNameAndImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupModel group = context.read<CouncilCubit>().group!;
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 15.w),
          SizedBox(
            width: 100.w,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5000),
                child: CachedNetworkImage(
                  placeholder:
                      (context, url) => CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                  imageUrl: group.groupImage,
                  fit: BoxFit.cover,
                  errorWidget:
                      (context, url, error) => Opacity(
                        opacity: 0.5,
                        child: Image.asset(Assets.sltLogo),
                      ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            height: 150.h,
            child: VerticalDivider(
              indent: 20.h,
              endIndent: 20.h,
              color: Colors.black,
              thickness: 1.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Center(
              child: Text(
                group.groupName,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: Constants.englishFont,
                  fontSize: 28.sp,
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
