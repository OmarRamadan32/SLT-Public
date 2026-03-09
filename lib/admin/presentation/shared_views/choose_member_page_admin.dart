import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/admin/data/models/choose_members_page_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/one_member_card_admin.dart';

// ignore: must_be_immutable
class ChooseMemberPageAdmin extends StatefulWidget {
  const ChooseMemberPageAdmin({
    super.key,
    required this.path,
    required this.chooseMemberPageModel,
  });
  final String path;
  final ChooseMembersPageModel chooseMemberPageModel;

  @override
  State<ChooseMemberPageAdmin> createState() => _ChooseMemberPageAdminState();
}

class _ChooseMemberPageAdminState extends State<ChooseMemberPageAdmin> {
  String? selectedUserId; // نخزن الـ id بدل index
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    _loadUsers();
    super.initState();
  }

  void _loadUsers() {
    UserCubit userCubit = context.read<UserCubit>();
    if (widget.chooseMemberPageModel.userNumber == 1) {
      userCubit.selectedUser = null;
    } else if (widget.chooseMemberPageModel.userNumber == 2) {
    } else if (widget.chooseMemberPageModel.userNumber == 3) {}
    userCubit.getUsersFromCollection(path: widget.path);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "اختر من القائمة",
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(1000.r),
        child: SizedBox(
          height: 60.r,
          width: 60.r,
          child: FloatingActionButton(
            onPressed: () {
              if (selectedUserId != null) {
                widget.chooseMemberPageModel.onSaved();
                context.pop();
              } else {
                Helpers.showSnackBar(context, "من فضلك اختر مستخدم");
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              "حفظ",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      child: BlocConsumer<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserErrorState) {
            return ErrorMessageWidget(message: state.errorMessage);
          } else if (state is UserLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else {
            final userCubit = context.read<UserCubit>();

            final filteredUsers =
                userCubit.usersList.where((user) {
                  if (_searchQuery.isEmpty) return true;
                  return user.name.toLowerCase().contains(
                    _searchQuery.toLowerCase(),
                  );
                }).toList();

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
                    final user = filteredUsers[index];
                    return OneMemberCardAdmin(
                      membersAccessLevel: user.accessLevel!,
                      key: ValueKey(user.id), // مهم لتحديث الـ UI بشكل صحيح
                      cardImage: user.imageUrl,
                      radioValue: true,
                      radioGroupValue: selectedUserId == user.id,
                      onChanged: (value) {
                        selectedUserId = user.id;
                        widget.chooseMemberPageModel.userNumber == 1
                            ? userCubit.selectedUser = user
                            : widget.chooseMemberPageModel.userNumber == 2
                            ? userCubit.selectedUserTwo = user
                            : widget.chooseMemberPageModel.userNumber == 3
                            ? userCubit.selectedUserThree = user
                            : null;
                        userCubit.updateUser();
                      },
                      cardTitle: user.name,
                    );
                  },
                ),
                Spaces.screenLastItemSpace70,
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is UserErrorState) {
            Helpers.showSnackBar(context, state.errorMessage);
          }
          if (state is UserSelectedState) {
            context.pop();
          }
        },
      ),
    );
  }
}
