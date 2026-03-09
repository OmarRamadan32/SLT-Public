import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';

class Styles {
  static TextStyle bottomNaviselectedItemTextStyle = TextStyle(
    fontSize: 12.sp,
    fontFamily: Constants.appFont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bottomNaviunselectedItemTextStyle = TextStyle(
    fontSize: 10.sp,
    fontFamily: Constants.appFont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle appBarTitleTextStyle = TextStyle(
    fontSize: 18.sp,
    fontFamily: Constants.appFont,
    fontWeight: FontWeight.w600,
  );
  //--------------
  // -------15
  static TextStyle textStyleP15 = TextStyle(
    fontSize: 15.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyleS15 = TextStyle(
    fontSize: 15.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );
  // -------13
  static TextStyle textStyleP13 = TextStyle(
    fontSize: 13.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyleS13 = TextStyle(
    fontSize: 13.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );
  // -------11
  static TextStyle textStyleP11 = TextStyle(
    fontSize: 11.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyleS11 = TextStyle(
    fontSize: 11.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );
  // -------10
  static TextStyle textStyleP10 = TextStyle(
    fontSize: 10.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyleS10 = TextStyle(
    fontSize: 10.sp,
    fontFamily: Constants.appFont,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.w600,
  );

  // -------18
  static TextStyle textStyleP18 = TextStyle(
    fontSize: 18.sp,
    fontFamily: Constants.appFont,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textStyleS18 = TextStyle(
    fontSize: 18.sp,
    fontFamily: Constants.appFont,
    fontWeight: FontWeight.w600,
  );

  //-----------------------------------------------

  static BoxShadow cardsBoxShadow = BoxShadow(
    color: Colors.black.withValues(alpha: 0.15),
    spreadRadius: 1,
    blurRadius: 1,
    offset: const Offset(0, 1),
  );
}
