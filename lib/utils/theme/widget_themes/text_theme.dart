import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';

import '../../constants/sizes.dart';

class LocalTextTheme {
  LocalTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: AppPallete.textPrimary,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: AppPallete.textPrimary,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppPallete.textPrimary,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppPallete.textPrimary,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppPallete.textPrimary,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppPallete.textPrimary,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppPallete.textPrimary,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: AppPallete.textPrimary,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppPallete.textPrimary.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppPallete.textPrimary,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppPallete.textPrimary,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: AppPallete.textWhite,
    ),
    headlineMedium: const TextStyle().copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      color: AppPallete.textWhite,
    ),
    headlineSmall: const TextStyle().copyWith(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: AppPallete.textWhite,
    ),
    titleLarge: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: AppPallete.textWhite,
    ),
    titleMedium: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppPallete.textWhite,
    ),
    titleSmall: const TextStyle().copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppPallete.textWhite,
    ),
    bodyLarge: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppPallete.textWhite,
    ),
    bodyMedium: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: AppPallete.textWhite,
    ),
    bodySmall: const TextStyle().copyWith(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppPallete.textWhite.withOpacity(0.5),
    ),
    labelLarge: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppPallete.greyColor,
    ),
    labelMedium: const TextStyle().copyWith(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: AppPallete.greyColor,
    ),
  );

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppPallete.darkGrey,
    suffixIconColor: AppPallete.darkGrey,
    labelStyle: const TextStyle().copyWith(
      fontSize: AppSize.fontSizeSmall,
      color: AppPallete.darkGrey,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: AppSize.fontSizeSmall,
      color: AppPallete.textPrimary,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: AppPallete.textPrimary,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.textPrimary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.errorColor),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 2, color: Colors.orangeAccent),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: AppPallete.greyColor,
    suffixIconColor: AppPallete.greyColor,
    labelStyle: const TextStyle().copyWith(
      fontSize: AppSize.fontSizeSmall,
      color: AppPallete.greyColor,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: AppSize.fontSizeSmall,
      color: AppPallete.greyColor,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: AppPallete.textWhite,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.lightGrey),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 1, color: AppPallete.errorColor),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusMedium)),
      borderSide: const BorderSide(width: 2, color: Colors.orangeAccent),
    ),
  );
}
