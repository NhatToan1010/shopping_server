import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';

class LocalChipTheme {
  LocalChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AppPallete.greyColor.withOpacity(0.5),
    labelStyle: const TextStyle(color: AppPallete.blackColor),
    selectedColor: AppPallete.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: AppPallete.whiteColor,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: AppPallete.greyColor.withOpacity(0.5),
    labelStyle: const TextStyle(color: AppPallete.whiteColor),
    selectedColor: AppPallete.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: AppPallete.whiteColor,
  );
}