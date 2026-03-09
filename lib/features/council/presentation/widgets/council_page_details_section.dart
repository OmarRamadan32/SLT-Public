import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';

class CouncilPageDetailsSection extends StatelessWidget {
  const CouncilPageDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    CouncilModel council = context.read<CouncilCubit>().council!;
    final String councilLeaderOneName = council.councilLeaderName;
    final String? councilLeaderTwoName = council.councilLeaderTwoName;
    final String councilLeaders =
        councilLeaderTwoName != null
            ? "$councilLeaderOneName/ $councilLeaderTwoName"
            : councilLeaderOneName;
    return Column(
      children: [
        DetailsRowWidget(
          cardsCount: 1,
          titles: ["قائد المجلس"],
          subTitles: [councilLeaders],
          primaryColorCount: 1,
        ),
        Spaces.space5,
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["رقم المجلس", "عدد المرشحين"],
          subTitles: [council.councilNumber.toString(), "غير متوفر"],
          primaryColorCount: 0,
        ),
      ],
    );
  }
}
