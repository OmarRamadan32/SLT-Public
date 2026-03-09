import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/choose_mention_card.dart';

class ChoosedUsersSection extends StatelessWidget {
  const ChoosedUsersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>();
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserSelectedState) {
          return Wrap(
            alignment: WrapAlignment.end,
            children: [
              ...List.generate(userCubit.selectedUsers.length, (index) {
                return ChooseMentionCard(
                  userModel: userCubit.selectedUsers[index],
                  onTap: () {
                    userCubit.excludeUser(userCubit.selectedUsers[index]);
                  },
                );
              }),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
