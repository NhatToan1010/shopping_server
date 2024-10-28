import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';

import '../../constants/sizes.dart';

class LocalButtonTheme {
  LocalButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppPallete.whiteColor,
      backgroundColor: AppPallete.primary,
      disabledForegroundColor: AppPallete.darkGrey,
      disabledBackgroundColor: AppPallete.darkerGrey,
      padding: const EdgeInsets.symmetric(vertical: AppSize.medium, horizontal: 10),
      textStyle: const TextStyle(
        fontSize: AppSize.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: AppPallete.whiteColor,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      ),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppPallete.whiteColor,
      backgroundColor: AppPallete.primary,
      disabledForegroundColor: AppPallete.darkGrey,
      disabledBackgroundColor: AppPallete.darkerGrey,
      padding: const EdgeInsets.symmetric(vertical: AppSize.medium, horizontal: 10),
      textStyle: const TextStyle(
        fontSize: AppSize.fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: AppPallete.whiteColor,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      ),
    ),
  );

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppPallete.blackColor,
      side: const BorderSide(color: AppPallete.primary),
      textStyle: const TextStyle(
        fontSize: AppSize.fontSizeMedium,
        color: AppPallete.blackColor,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
        side: BorderSide(width: 2),
      ),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppPallete.whiteColor,
      side: const BorderSide(color: AppPallete.secondary),
      textStyle: const TextStyle(
        fontSize: AppSize.fontSizeMedium,
        color: AppPallete.whiteColor,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
        side: BorderSide(width: 2),
      ),
    ),
  );

  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: AppPallete.blackColor,
      textStyle: const TextStyle(
        fontSize: AppSize.fontSizeSmall,
        color: AppPallete.blackColor,
        fontWeight: FontWeight.w600,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      ),
    ),
  );

  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      elevation: 0,
      foregroundColor: AppPallete.whiteColor,
      textStyle: const TextStyle(
        fontSize: AppSize.fontSizeSmall,
        color: AppPallete.blackColor,
        fontWeight: FontWeight.w600,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      ),
    ),
  );

  static const lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    shape: CircleBorder(),
    backgroundColor: AppPallete.primary,
    foregroundColor: AppPallete.whiteColor,
    elevation: 0,
  );

  static const darkFloatingActionButtonTheme = FloatingActionButtonThemeData(
    shape: CircleBorder(),
    backgroundColor: AppPallete.secondary,
    foregroundColor: AppPallete.whiteColor,
    elevation: 0,
  );
}
