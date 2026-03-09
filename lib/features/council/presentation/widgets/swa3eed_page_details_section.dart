import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';

class Swa3eedPageDetailsSection extends StatelessWidget {
  const Swa3eedPageDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    CouncilCubit cubit = context.read<CouncilCubit>();
    Swa3edModel swa3ed = cubit.swa3ed!;
    return Column(
      children: [
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["قائد السواعد", "مسؤولة السواعد"],
          subTitles: [swa3ed.swa3edLeaderName, swa3ed.swa3edLeaderTwoName],
          primaryColorCount: 2,
        ),
        Spaces.space5,
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["قوة السواعد", "رقم المجلس"],
          subTitles: [
            "${swa3ed.swa3edMembers.length}",
            "${swa3ed.councilNumber}",
          ],
          primaryColorCount: 0,
          flexes: [1, 2],
        ),
      ],
    );
  }
}
