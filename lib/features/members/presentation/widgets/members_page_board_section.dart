import 'package:flutter/material.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';

class MembersPageBoardSection extends StatelessWidget {
  const MembersPageBoardSection({super.key, required this.usersModels});
  final List<UserModel> usersModels;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleWidget(title: "مجلس الإدارة الأساسي"),
        Spaces.space10,
        CirlceImageAndTitleRowWidget(usersModels: usersModels),
      ],
    );
  }
}
