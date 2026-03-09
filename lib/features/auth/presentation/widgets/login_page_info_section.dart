import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';

class LoginPageInfoSection extends StatelessWidget {
  const LoginPageInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Developed & Designed by: ",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontFamily: Constants.englishFont,
                color: Theme.of(context).primaryColor,
                fontSize: 10.sp,
              ),
            ),
            Text(
              "Omar Ramadan",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontFamily: Constants.englishFont,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        Spaces.space5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Management: ",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontFamily: Constants.englishFont,
                color: Theme.of(context).primaryColor,
                fontSize: 10.sp,
              ),
            ),
            Text(
              "Michael Alpert & Habiba Gomaa ",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontFamily: Constants.englishFont,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
