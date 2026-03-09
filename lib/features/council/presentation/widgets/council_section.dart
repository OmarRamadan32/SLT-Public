import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/cards/half_image_card_widget/half_image_card.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/views/councils_section_loading_view.dart';
import 'package:new_slt/features/council/presentation/widgets/council_section_past_councils_section.dart';

class CouncilSection extends StatefulWidget {
  const CouncilSection({super.key});

  @override
  State<CouncilSection> createState() => _CouncilSectionState();
}

class _CouncilSectionState extends State<CouncilSection> {
  @override
  void initState() {
    context.read<CouncilCubit>().getAllCouncils();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouncilCubit, CouncilState>(
      builder: (context, state) {
        if (state is CouncilLoadingState) {
          return const CouncilsSectionLoadingView();
        } else if (state is CouncilErrorState) {
          return ErrorMessageWidget(isCentered: true, message: state.message);
        } else {
          CouncilCubit cubit = context.read<CouncilCubit>();
          CouncilModel? currentCouncil =
              cubit.councils
                  .where((element) => element.isCurrent == true)
                  .firstOrNull;
          return Column(
            children: [
              Spaces.space10,
              currentCouncil == null
                  ? const SizedBox()
                  : GestureDetector(
                    onTap: () {
                      context.push(
                        "${AppRouter.kCouncilPage}/${currentCouncil.id}",
                      );
                    },
                    child: HalfImageCard(
                      cardImage: currentCouncil.councilImage,
                      cardLeaderOneName: currentCouncil.councilLeaderName,
                      cardLeaderTwoName: "عدد المرشحين:  --",
                      cardTitle: "المجلس ال${currentCouncil.councilNumber}",
                    ),
                  ),
              Spaces.inSectionSpace20,
              const TitleWidget(title: "المجالس السابقة", isCentered: false),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 120.w,
                  child: Divider(
                    color: Theme.of(context).primaryColor,
                    thickness: 1.3,
                  ),
                ),
              ),
              Spaces.space5,
              const CouncilSectionPastCouncilsSection(),
              Spaces.screenLastItemSpace70,
            ],
          );
        }
      },
    );
  }
}
