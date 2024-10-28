import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class LocalAppBarTheme {
  LocalAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: AppPallete.transparentColor,
    surfaceTintColor: AppPallete.transparentColor,
    iconTheme: IconThemeData(color: AppPallete.blackColor, size: AppSize.iconMedium),
    actionsIconTheme: IconThemeData(color: AppPallete.blackColor, size: AppSize.iconMedium),
    titleTextStyle: TextStyle(
      fontSize: AppSize.fontSizeLarge,
      fontWeight: FontWeight.w600,
      color: AppPallete.blackColor,
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: AppPallete.transparentColor,
    surfaceTintColor: AppPallete.transparentColor,
    iconTheme: IconThemeData(color: AppPallete.whiteColor, size: AppSize.iconMedium),
    actionsIconTheme: IconThemeData(color: AppPallete.whiteColor, size: AppSize.iconMedium),
    titleTextStyle: TextStyle(
      fontSize: AppSize.fontSizeLarge,
      fontWeight: FontWeight.w600,
      color: AppPallete.whiteColor,
    ),
  );
}
