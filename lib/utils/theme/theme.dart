import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/theme/widget_themes/app_bar_theme.dart';
import 'package:shopping_server/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:shopping_server/utils/theme/widget_themes/button_theme.dart';
import 'package:shopping_server/utils/theme/widget_themes/check_box_theme.dart';
import 'package:shopping_server/utils/theme/widget_themes/chip_theme.dart';
import 'package:shopping_server/utils/theme/widget_themes/switch_theme.dart';
import 'package:shopping_server/utils/theme/widget_themes/text_theme.dart';

class LocalTheme {
  LocalTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: AppPallete.backgroundLight,
    scaffoldBackgroundColor: AppPallete.lightGrey,
    textTheme: LocalTextTheme.lightTextTheme,
    elevatedButtonTheme: LocalButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: LocalButtonTheme.lightOutlinedButtonTheme,
    textButtonTheme: LocalButtonTheme.lightTextButtonTheme,
    appBarTheme: LocalAppBarTheme.lightAppBarTheme,
    checkboxTheme: LocalCheckboxTheme.lightCheckboxTheme,
    chipTheme: LocalChipTheme.lightChipTheme,
    inputDecorationTheme: LocalTextTheme.lightInputDecorationTheme,
    bottomSheetTheme: LocalBottomSheetTheme.lightBottomSheetTheme,
    floatingActionButtonTheme: LocalButtonTheme.lightFloatingActionButtonTheme,
    switchTheme: LocalSwitchTheme.lightSwitchTheme
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: AppPallete.backgroundDark,
    scaffoldBackgroundColor: AppPallete.blackColor,
    textTheme: LocalTextTheme.darkTextTheme,
    elevatedButtonTheme: LocalButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: LocalButtonTheme.darkOutlinedButtonTheme,
    textButtonTheme: LocalButtonTheme.darkTextButtonTheme,
    appBarTheme: LocalAppBarTheme.darkAppBarTheme,
    checkboxTheme: LocalCheckboxTheme.darkCheckboxTheme,
    chipTheme: LocalChipTheme.darkChipTheme,
    inputDecorationTheme: LocalTextTheme.darkInputDecorationTheme,
    bottomSheetTheme: LocalBottomSheetTheme.darkBottomSheetTheme,
    floatingActionButtonTheme: LocalButtonTheme.darkFloatingActionButtonTheme,
    switchTheme: LocalSwitchTheme.darkSwitchTheme
  );
}

