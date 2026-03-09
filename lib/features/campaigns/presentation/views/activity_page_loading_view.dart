import 'package:flutter/material.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/activity_image.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/core/widgets/title_widget.dart';

class ActivityPageLoadingView extends StatelessWidget {
  const ActivityPageLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoadingView(
      cardsCount: 1,
      card: Column(
        children: [
          Spaces.inSectionSpace20,
          const TitleWidget(title: "------------"),
          Spaces.inSectionSpace20,
          const ActivityImage(imageUrl: ""),
          Spaces.inSectionSpace20,
          Column(
            children: [
              const DetailsRowWidget(
                cardsCount: 1,
                titles: ["مسؤولين النشاط"],
                subTitles: ["------------"],
                primaryColorCount: 1,
              ),
              Spaces.space5,
              const DetailsRowWidget(
                cardsCount: 2,
                titles: ["عدد المنضمين", "رقم الحملة"],
                subTitles: ["---", "-------"],
                primaryColorCount: 0,
                flexes: [1, 2],
              ),
              Spaces.inSectionSpace20,
              const DetailsBoxWidget(
                content:
                    "--------------------------------------------------------------",
              ),
            ],
          ),
          Spaces.sectionsSpace40,
          const TitleWidget(title: "اعضاء التيم"),
          Spaces.space10,
          CirlceImageAndTitleRowWidget(
            usersModels: [
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
            ],
          ),
          Spaces.sectionsSpace40,
        ],
      ),
    );
  }
}
