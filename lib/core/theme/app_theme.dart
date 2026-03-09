import 'package:flutter/material.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/styles.dart';

class AppTheme {
  // ---------------------------- Light Theme ----------------------------
  static final ThemeData lightTheme = ThemeData(
    snackBarTheme: SnackBarThemeData(backgroundColor: Constants.secondaryColor),
    primaryColor: Constants.primaryColor,
    textTheme: TextTheme(
      titleMedium: Styles.textStyleP15.copyWith(color: Constants.primaryColor),
      titleLarge: Styles.textStyleS18.copyWith(color: Constants.primaryColor),
      titleSmall: Styles.textStyleP13.copyWith(color: Constants.primaryColor),
      bodySmall: Styles.textStyleP11.copyWith(color: Constants.basicColor900),
      bodyMedium: Styles.textStyleP13.copyWith(color: Constants.basicColor900),
      bodyLarge: Styles.textStyleP15.copyWith(color: Constants.basicColor900),
      labelSmall: Styles.textStyleP10.copyWith(color: Colors.black54),
      labelMedium: Styles.textStyleP13.copyWith(color: Colors.black54),
      labelLarge: Styles.textStyleP15.copyWith(color: Colors.black54),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Constants.secondaryColor,
      titleTextStyle: Styles.textStyleP18.copyWith(
        color: Constants.primaryColor,
      ),
      iconTheme: IconThemeData(color: Constants.primaryColor),
    ),
    scaffoldBackgroundColor: Constants.backgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Constants.secondaryColor,
      selectedItemColor: Constants.darkTextColor,
      unselectedItemColor: Constants.basicColor800,
      selectedLabelStyle: Styles.bottomNaviselectedItemTextStyle,
      unselectedLabelStyle: Styles.bottomNaviunselectedItemTextStyle,
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Constants.secondaryColor),
    iconTheme: IconThemeData(color: Constants.primaryColor),
  );
  //------------------------- DARK THEME -------------------------
  static final ThemeData darkTheme = ThemeData(
    //
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Constants.darkSecondaryColor,
      contentTextStyle: Styles.textStyleP13.copyWith(),
    ),
    primaryColor: Constants.darkPrimaryColor,
    textTheme: TextTheme(
      titleMedium: Styles.textStyleP15.copyWith(
        color: Constants.darkPrimaryColor,
      ),
      titleLarge: Styles.textStyleS18.copyWith(
        color: Constants.darkPrimaryColor,
      ),
      titleSmall: Styles.textStyleP13.copyWith(
        color: Constants.darkPrimaryColor,
      ),
      bodySmall: Styles.textStyleP11.copyWith(color: Constants.darkTextColor),
      bodyMedium: Styles.textStyleP13.copyWith(color: Constants.darkTextColor),
      bodyLarge: Styles.textStyleP15.copyWith(color: Constants.darkTextColor),
      labelSmall: Styles.textStyleP10.copyWith(
        color: Constants.darkBasicColor800,
      ),
      labelMedium: Styles.textStyleP13.copyWith(
        color: Constants.darkBasicColor800,
      ),
      labelLarge: Styles.textStyleP15.copyWith(
        color: Constants.darkBasicColor800,
      ),
    ),
    scaffoldBackgroundColor: Constants.darkBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Constants.darkSecondaryColor,
      selectedItemColor: Constants.darkTextColor,
      unselectedItemColor: Colors.black87,
      selectedLabelStyle: Styles.bottomNaviselectedItemTextStyle.copyWith(
        color: Constants.darkPrimaryColor,
      ),
      unselectedLabelStyle: Styles.bottomNaviunselectedItemTextStyle.copyWith(
        color: Colors.black,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Constants.darkSecondaryColor,
      titleTextStyle: Styles.textStyleP18.copyWith(
        color: Constants.darkPrimaryColor,
      ),
      iconTheme: IconThemeData(color: Constants.darkPrimaryColor),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: Constants.darkSecondaryColor),
    iconTheme: IconThemeData(color: Constants.darkPrimaryColor),
  );
}
