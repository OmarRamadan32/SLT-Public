import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/drawer_widget/developer_name_widget.dart';

class DrawerWidgetInfo extends StatelessWidget {
  const DrawerWidgetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const DeveloperNameWidget(label: "Developed By Omar Ramadan"),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            "Verion 1.0.5",
            style: TextStyle(
              fontSize: 10.sp,
              fontFamily: Constants.englishFont,
              fontWeight: FontWeight.w100,
              color: Colors.black,
            ),
          ),
        ),
        Spaces.space5,
      ],
    );
  }
}
