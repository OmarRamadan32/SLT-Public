import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class UnauthorizedSignWidget extends StatelessWidget {
  const UnauthorizedSignWidget({super.key, required this.message, this.height});
  final UnauthorizedMessages message;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(height: height?.h, Assets.stopIcon),
            ),
            Opacity(
              opacity: 0.4,
              child: ArabicTextWidget(
                textAlign: TextAlign.center,
                text:
                    message == UnauthorizedMessages.memberShipMessage
                        ? "هذا المحتوي خاص بأعضاء الفريق فقط"
                        : "ليس لديك صلاحية الوصول لهذا المحتوي",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
