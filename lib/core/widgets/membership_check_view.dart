import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/core/widgets/unauthorized_sign_widget.dart';

class MembershipCheckView extends StatelessWidget {
  const MembershipCheckView({super.key, required this.view});
  final Widget view;

  @override
  Widget build(BuildContext context) {
    String userAccountType = context.read<UserCubit>().userModel!.accountType;
    if (userAccountType != Constants.normalMember) {
      return const UnauthorizedSignWidget(
        message: UnauthorizedMessages.memberShipMessage,
      );
    } else {
      return view;
    }
  }
}
