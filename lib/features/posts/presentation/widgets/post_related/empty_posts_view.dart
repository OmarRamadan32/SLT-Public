import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';

class EmptyPostsView extends StatelessWidget {
  const EmptyPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TitleWidget(title: "المنشورات"),
        Spaces.sectionsSpace40,
        const Center(child: ArabicTextWidget(text: "لا يوجد منشورات")),
      ],
    );
  }
}
