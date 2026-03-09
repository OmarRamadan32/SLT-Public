import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_image_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';

class ChangeImageBottomSheetView extends StatelessWidget {
  const ChangeImageBottomSheetView({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spaces.inSectionSpace20,
          ArabicTextWidget(
            text: "إضغط علي الصورة للتغير",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Spaces.inSectionSpace20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ChooseImageWidget(initialImage: image),
          ),
          const Spacer(),
          CustomButtonAdmin(text: "حفظ", onPressed: () {}),
          Spaces.inSectionSpace20,
        ],
      ),
    );
  }
}
