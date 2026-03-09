import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/core/widgets/unauthorized_sign_widget.dart';

class AccessLevelCheckView extends StatelessWidget {
  const AccessLevelCheckView({
    super.key,
    required this.authorizedAccessLevel,
    required this.view,
  });
  final int authorizedAccessLevel;
  final Widget view;
  @override
  Widget build(BuildContext context) {
    int userAccessLevel = context.read<UserCubit>().getUserAccessLevel();
    if (userAccessLevel < authorizedAccessLevel) {
      return const UnauthorizedSignWidget(
        message: UnauthorizedMessages.accessLevelMessage,
      );
    } else {
      return view;
    }
  }
}
