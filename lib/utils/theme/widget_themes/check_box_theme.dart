import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';

class LocalCheckboxTheme {
  LocalCheckboxTheme._();

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppPallete.whiteColor;
      } else {
        return AppPallete.transparentColor;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppPallete.primary;
      } else {
        return AppPallete.transparentColor;
      }
    }),
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData(
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppPallete.whiteColor;
      } else {
        return AppPallete.blackColor;
      }
    }),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppPallete.secondary; //Need to change
      } else {
        return AppPallete.blackColor;
      }
    }),
  );
}
