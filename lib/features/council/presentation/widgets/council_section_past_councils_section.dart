import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/widgets/past_council_card.dart';

class CouncilSectionPastCouncilsSection extends StatelessWidget {
  const CouncilSectionPastCouncilsSection({super.key});

  @override
  Widget build(BuildContext context) {
    CouncilCubit cubit = context.read<CouncilCubit>();
    List<CouncilModel> pastCouncils =
        cubit.councils.where((element) => element.isCurrent == false).toList();
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: pastCouncils.length,
        itemBuilder:
            (context, index) => GestureDetector(
              onTap: () {
                context.push(
                  '${AppRouter.kCouncilPage}/${pastCouncils[index].id}',
                );
              },
              child: PastCouncilCard(
                cardLeaderName: pastCouncils[index].councilLeaderName,
                cardImageUrl: pastCouncils[index].councilImage,
                cardTitle: "${pastCouncils[index].councilNumber}",
              ),
            ),
      ),
    );
  }
}
