import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class AppStatePage extends StatelessWidget {
  const AppStatePage({
    super.key,
    required this.message,
    required this.stateImage,
    this.url,
  });
  final String message;
  final String stateImage;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(stateImage, height: 500.h, width: double.infinity),
          ArabicTextWidget(
            maxLines: 10,
            text: message,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: 20.sp,
            ),
          ),
          Spaces.inSectionSpace20,
          if (url != null)
            TextButton(
              child: ArabicTextWidget(
                text: 'اضغط هنا للتحديث',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: Constants.appNameFont,
                  fontSize: 20.sp,
                ),
              ),
              onPressed: () async {
                Helpers.launchURL(url!);
              },
            ),
        ],
      ),
    );
  }
}
