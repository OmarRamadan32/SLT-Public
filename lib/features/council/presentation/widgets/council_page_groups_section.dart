import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';

class CouncilPageGroupsSection extends StatelessWidget {
  const CouncilPageGroupsSection({super.key});

  @override
  Widget build(BuildContext context) {
    List<GroupModel> groups = context.read<CouncilCubit>().groups;
    return Column(
      children: [
        const TitleWidget(title: "المجاميع", isCentered: true),
        Spaces.sectionsSpace40,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                groups.length,
                (index) => GestureDetector(
                  onTap: () {
                    context.push('${AppRouter.kGroupPage}/${groups[index].id}');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: CirlceImageAndTitleWidget(
                      userImage: groups[index].groupImage,
                      userName: groups[index].groupName,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
