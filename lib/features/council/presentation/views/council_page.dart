import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/cards/full_image_card/full_image_card.dart';
import 'package:new_slt/features/council/presentation/cubit/council_cubit.dart';
import 'package:new_slt/features/council/presentation/views/council_page_loading_view.dart';
import 'package:new_slt/features/council/presentation/widgets/council_page_details_section.dart';
import 'package:new_slt/features/council/presentation/widgets/council_page_groups_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_feature.dart';

class CouncilPage extends StatefulWidget {
  const CouncilPage({super.key, required this.councilId});
  final String councilId;

  @override
  State<CouncilPage> createState() => _CouncilPageState();
}

class _CouncilPageState extends State<CouncilPage> {
  @override
  void initState() {
    context.read<CouncilCubit>().getCouncilEventsById(
      councilId: widget.councilId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ScreenWidget(
      isMainScreen: false,
      child: SingleChildScrollView(
        child: BlocBuilder<CouncilCubit, CouncilState>(
          builder: (context, state) {
            if (state is CouncilLoadingState) {
              return const CouncilPageLoadingView();
            } else if (state is CouncilErrorState) {
              return ErrorMessageWidget(
                isCentered: true,
                message: state.message,
              );
            } else {
              CouncilCubit councilCubit = context.read<CouncilCubit>();
              final String schedulePath =
                  '${BackendEndpoints.councilCollection}/${councilCubit.council!.id}/${BackendEndpoints.schedulesCollection}';
              return Column(
                children: [
                  Spaces.inSectionSpace20,
                  ScheduleFeature(
                    authorizedUsers: [
                      councilCubit.council!.councilLeaderId,
                      councilCubit.council!.councilLeaderTwoId!,
                      ...councilCubit.council!.councilMembersModel.map(
                        (e) => e.id!,
                      ),
                    ],
                    path: schedulePath,
                  ),
                  Spaces.sectionsSpace40,
                  SizedBox(
                    width: 200.w,
                    child: Divider(color: theme.primaryColor, thickness: 1.3),
                  ),
                  Spaces.space5,
                  const CouncilPageDetailsSection(),
                  Spaces.sectionsSpace40,
                  if (councilCubit.swa3ed != null)
                    GestureDetector(
                      onTap: () {
                        context.pushReplacement(AppRouter.kSwa3eedPage);
                      },
                      child: FullImageCard(
                        cardImage: councilCubit.swa3ed!.swa3edImage,
                        cardTitle: "السواعد",
                        cardLeaderOne: councilCubit.swa3ed!.swa3edLeaderName,
                        cardLeaderTwo: councilCubit.swa3ed!.swa3edLeaderTwoName,
                      ),
                    ),
                  Spaces.sectionsSpace40,
                  if (councilCubit.groups.isNotEmpty)
                    const CouncilPageGroupsSection(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
