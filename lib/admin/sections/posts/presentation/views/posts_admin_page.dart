import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/posts/data/models/fetch_posts_page_model.dart';

class PostsAdminPage extends StatelessWidget {
  const PostsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "البوستات",
      child: Column(
        children: [
          DashboardSecCard(
            icon: FontAwesomeIcons.plus,
            onTap: () {
              context.push(AppRouter.kAddPostAdminPage);
            },
            title: "اضافة بوست",
          ),
          DashboardSecCard(
            icon: FontAwesomeIcons.plus,
            onTap: () {
              context.push(AppRouter.kAddSpecialPostAdminPage);
            },
            title: "اضافة بوست بخاصية التسجيل",
          ),
          const SmallNoteWidget(
            content:
                "بوست بخاصية التسجيل: يظهر البوست للجميع مع زر التسجيل في البوست ويمكنك الإطلاع علي كل من قاموا بالتسجيل عن طريق الصفحة الخاصة بالبوست",
          ),
          Spaces.inSectionSpace20,
          DashboardSecCard(
            icon: FontAwesomeIcons.trashCan,
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.kFetchPostsAdminPage,
                extra: ShowPostsPageModel(
                  isDeletePage: true,
                  title: "حذف بوست",
                ),
              );
            },
            title: "حذف بوست",
          ),
          DashboardSecCard(
            icon: FontAwesomeIcons.penToSquare,
            onTap: () {
              GoRouter.of(context).push(
                AppRouter.kFetchPostsAdminPage,
                extra: ShowPostsPageModel(
                  isDeletePage: false,
                  title: "تعديل بوست",
                ),
              );
            },
            title: "تعديل بوست",
          ),
        ],
      ),
    );
  }
}
