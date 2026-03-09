import 'package:flutter/material.dart';

abstract class Constants {
  static const String appVersion = '1.3.0';
  // --------------------------------------------------------------------------
  // Light
  // static final Color primaryColor = const Color(0xFF008080); // the actual color
  // static final Color primaryColor =  Colors.teal.shade900;
  static final Color primaryColor = const Color(0xFF477A71);
  //---
  static final Color secondaryColor = const Color(0xFFEAECEE);
  //   static final Color secondaryColor = const Color(0xFFEAEADE);  // the actual color
  static final Color lightGreyColor = Colors.grey[300]!;
  static final Color backgroundColor = const Color(0xFFF5F7F8);
  static Color basicColor900 = const Color(0xFF2C3E50);
  static Color basicColor800 = const Color(0xFF95A5A6);
  //--------------------------------------------------------------------------
  // Dark
  static final Color darkPrimaryColor = const Color(0xFFF9A826);
  static final Color darkSecondaryColor = const Color(0xFF1F1F1F);
  static final Color darkBackgroundColor = const Color(0xFF121212);
  static final Color darkBasicColor900 = const Color(0xFFE0E0E0);
  static final Color darkBasicColor800 = const Color(0xFF9E9E9E);
  static final Color darkTextColor = const Color(0xFFE0E0E0);
  //----------------------------------------
  static const String appFont = 'slttitle';
  static const String englishFont = 'sltFont';
  static const String appNameFont = 'appNameFont';
  // ---------------------------------------
  // Team titles
  static const String teamLeader = 'قائد الفريق';
  static const String viceLeader = 'نائب قائد فريق';
  static const String assistantLeader = 'مساعد قائد فريق';
  static const String femaleLeader = "مسؤولة الأنسات";
  static const String leader = 'قائد';
  static const String captain = 'رائد';
  static const String female = 'انسة';
  static const String normalMember = 'عضو';
  static const String guestMember = 'زائر';
  static const String newMember = 'مرشح';
  //-----------------------------------------
  static const int adminAccessLevel = 5;
  //-----------------------------------------
  // Team Messages
  static const String punishment1Message = 'تم إضافة قرار لفت نظر في سجلك';
  static const String punishment2Message = 'تم إضافة قرار إنذار بالفصل في سجلك';
  static const String punishment3Message = 'لقد تم فصلك من الفريق';
  // Shared Preferences
  static const String isDarkMode = 'isDarkMode';
  static const String isFirstTime = 'isFirstTime';
  // Firebase Remote Config Keys
  static const String appStateConfig = 'appState';
  static const String appTitleConfig = 'appTitle';
  static const String appVersionConfig = 'appVersion';
  static const String highlightConfig = 'highlight';
  // Store (for updates)
  static const String appStoreLink = "https://apkpure.com/slt/com.tng.slt";
}
