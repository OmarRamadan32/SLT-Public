import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/admin/data/models/choose_members_page_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';

class ChooseMultibleMembersWidgetAdmin extends StatelessWidget {
  const ChooseMultibleMembersWidgetAdmin({
    super.key,
    required this.cardTitle,
    required this.searchPath,
    required this.onSavedFunction,
    this.searchField,
    this.icon,
    this.searchDocument,
    this.isNewUsers,
    this.where, this.requiredAccessLevel, this.authorizedIds,
  });
  final String cardTitle;
  final String searchPath;
  final String? searchField;
  final String? searchDocument;
  final Function onSavedFunction;
  final bool? isNewUsers;
  final Map<String, dynamic>? where;
  final IconData? icon;
  final int? requiredAccessLevel;
  final List<String>? authorizedIds;

  // ! the default value of [Where] in getUsersFromCollection is [UserAccountType: normalMember]

  @override
  Widget build(BuildContext context) {
    return DashboardSecCard(
      authorizedIds: authorizedIds,
      requiredAccessLevel: requiredAccessLevel,
      icon: icon,
      onTap: () {
        (context).push(
          "${AppRouter.kChooseMultibleMembersPage}?path=$searchPath",
          extra: ChooseMembersPageModel(
            onSaved: () {
              onSavedFunction();
            },
            documentId: searchDocument,
            fieldName: searchField,
            isNewUsers: isNewUsers,
            where: where,
          ),
        );
      },
      title: cardTitle,
    );
  }
}
