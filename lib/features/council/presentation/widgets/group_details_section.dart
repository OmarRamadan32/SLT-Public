import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';

class GroupDetailsSection extends StatelessWidget {
  const GroupDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupModel group = context.read<CouncilCubit>().group!;
    return Column(
      children: [
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["المجموعة", "المجلس"],
          subTitles: [
            group.groupNumber.toString(),
            group.councilNumber.toString(),
          ],
          primaryColorCount: 0,
          flexes: [1, 2],
        ),
        Spaces.space5,
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["عدد الدروع", "عدد المرشحين"],
          subTitles: [
            group.groupShields.length.toString(),
            group.groupMembers.length.toString(),
          ],
          primaryColorCount: 0,
          flexes: [2, 1],
        ),
      ],
    );
  }
}
