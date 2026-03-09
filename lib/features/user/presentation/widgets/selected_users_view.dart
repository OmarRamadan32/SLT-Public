import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/users_manager_cubit/users_manager_cubit.dart';

class SelectedUsersView extends StatelessWidget {
  const SelectedUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    UsersManagerCubit usersManagerCubit = context.read<UsersManagerCubit>();
    return const Placeholder();
  }
}
// this is the widget that will be used to show the selected users