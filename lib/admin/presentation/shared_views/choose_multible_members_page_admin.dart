import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/admin/data/models/choose_members_page_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/multible_members_card_admin.dart';

class ChooseMultibleMembersPage extends StatefulWidget {
  const ChooseMultibleMembersPage({
    super.key,
    required this.path,
    required this.chooseMemberPageModel,
  });
  final String path;
  final ChooseMembersPageModel chooseMemberPageModel;

  @override
  State<ChooseMultibleMembersPage> createState() =>
      _ChooseMultibleMembersPageState();
}

class _ChooseMultibleMembersPageState extends State<ChooseMultibleMembersPage> {
  final Set<String> selectedUserIds = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _loadUsers();
    });
  }

  void _loadUsers() {
    final userCubit = context.read<UserCubit>();

    // تهيئة الاختيارات
    userCubit.selectedUsers = [];

    if (widget.chooseMemberPageModel.fieldName == null) {
      if (widget.chooseMemberPageModel.isNewUsers == true) {
        userCubit.getnewUsers();
      } else {
        userCubit.getUsersFromCollection(
          path: widget.path,
          where: widget.chooseMemberPageModel.where,
        );
      }
    } else {
      userCubit.getUsersFromField(
        path: widget.path,
        documentId: widget.chooseMemberPageModel.documentId!,
        fieldName: widget.chooseMemberPageModel.fieldName!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = context.watch<UserCubit>();
    final theme = Theme.of(context);

    final filteredUsers =
        userCubit.usersList.where((user) {
          if (_searchQuery.isEmpty) return true;
          return user.name.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return DashboardScreenWidget(
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(1000.r),
        child: SizedBox(
          height: 60.r,
          width: 60.r,
          child: FloatingActionButton(
            onPressed: () async {
              final selectedUsers =
                  userCubit.usersList
                      .where((u) => selectedUserIds.contains(u.id))
                      .toList();

              if (selectedUsers.isEmpty) {
                Helpers.showSnackBar(context, "من فضلك اختر مستخدمين");
                return;
              }
              userCubit.chooseUsers(selectedUsers);
              widget.chooseMemberPageModel.onSaved();
              context.pop();
            },
            backgroundColor: theme.primaryColor,
            child: Text(
              "حفظ",
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      appBarTitle: "اختر من القائمة",
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const LoadingWidget(isCentered: true);
          }
          if (state is UserErrorState) {
            return ErrorMessageWidget(
              message: state.errorMessage,
              isCentered: true,
            );
          }
          if (userCubit.usersList.isEmpty) {
            return const EmptyViewWidget(
              isCentered: true,
              message: "لا يوجد مستخدمين",
            );
          }

          return Column(
            children: [
              // صندوق البحث
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: TextField(
                  controller: _searchController,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        Theme.of(
                          context,
                        ).bottomNavigationBarTheme.backgroundColor,
                    hintText: "ابحث بالاسم...",
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    hintTextDirection: TextDirection.rtl,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        width: 1.5,
                        color:
                            Theme.of(
                              context,
                            ).bottomNavigationBarTheme.backgroundColor!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        width: 1.5,
                        color:
                            Theme.of(
                              context,
                            ).bottomNavigationBarTheme.backgroundColor!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              // القائمة
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final member = filteredUsers[index];
                  final selected = selectedUserIds.contains(member.id);

                  return MultibleMembersCard(
                    key: ValueKey(member.id),
                    userModel: member,
                    selected: selected,
                    index: index,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selectedUserIds.add(member.id!);
                        } else {
                          selectedUserIds.remove(member.id!);
                        }
                      });
                    },
                    onTap: () {
                      setState(() {
                        if (selected) {
                          selectedUserIds.remove(member.id);
                        } else {
                          selectedUserIds.add(member.id!);
                        }
                      });
                    },
                  );
                },
              ),
              Spaces.screenLastItemSpace70,
            ],
          );
        },
      ),
    );
  }
}
