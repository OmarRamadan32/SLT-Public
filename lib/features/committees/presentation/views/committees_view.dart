import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/features/committees/presentation/cubit/committee_cubit.dart';
import 'package:new_slt/features/committees/presentation/views/committees_loading_view.dart';
import 'package:new_slt/features/committees/presentation/widgets/committee_card.dart';

class CommitteesView extends StatefulWidget {
  const CommitteesView({super.key});

  @override
  State<CommitteesView> createState() => _CommitteesViewState();
}

class _CommitteesViewState extends State<CommitteesView> {
  @override
  void initState() {
    context.read<CommitteeCubit>().getAllCommittees();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spaces.inSectionSpace20,
        BlocBuilder<CommitteeCubit, CommitteeState>(
          builder: (context, state) {
            if (state is CommitteeLoadingState) {
              return const CommitteesLoadingView();
            } else if (state is CommitteeErrorState) {
              return ErrorMessageWidget(
                isCentered: true,
                message: state.message,
              );
            } else {
              CommitteeCubit committeeCubit = context.read<CommitteeCubit>();
              if (committeeCubit.committees.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: committeeCubit.committees.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.push(
                              AppRouter.kCommitteePage,
                              extra: committeeCubit.committees[index],
                            );
                          },
                          child: CommitteeCard(
                            committeeModel: committeeCubit.committees[index],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                );
              } else {
                return const EmptyViewWidget(
                  isCentered: true,
                  message: 'لا توجد أي لجان',
                );
              }
            }
          },
        ),
        Spaces.screenLastItemSpace70,
      ],
    );
  }
}
