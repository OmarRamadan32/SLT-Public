import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/widgets/group_leader_widget.dart';

/*
  in this Widget if the Council is current it will show the group leaders in image and name
  but if the Council is not current it will show the group leaders in Details Row
*/

class GroupLeadersDetailsRowSection extends StatelessWidget {
  const GroupLeadersDetailsRowSection({
    super.key,
    required this.isCurrentCouncil,
  });

  final bool isCurrentCouncil;

  @override
  Widget build(BuildContext context) {
    final GroupModel group = context.read<CouncilCubit>().group!;
    if (isCurrentCouncil) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [...List.generate(3, (index) => const GroupLeaderWidget())],
      );
    } else {
      return Column(
        children: [
          DetailsRowWidget(
            cardsCount: 1,
            titles: ["قائد المجموعة"],
            subTitles: [(group.groupLeaderName)],
            primaryColorCount: 1,
          ),
          Spaces.space5,
          DetailsRowWidget(
            cardsCount: 2,
            titles: ["رائد المجموعة", "مسؤولة انسات المجموعة"],
            subTitles: [
              (group.groupCaptainName),
              (group.groupFemaleLeaderName),
            ],
            primaryColorCount: 2,
          ),
        ],
      );
    }
  }
}
