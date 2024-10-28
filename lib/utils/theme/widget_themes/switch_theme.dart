import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';

class LocalSwitchTheme {
  LocalSwitchTheme._();

  static final lightSwitchTheme = SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppPallete.primary;
      }
      else {
        return AppPallete.greyColor;
      }
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppPallete.transparentColor;
      }
      else {
        return AppPallete.darkGrey;
      }
    }),

    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppPallete.lightGrey;
      }
      else {
        return AppPallete.darkGrey;
      }
    }),
  );

  static final darkSwitchTheme = SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppPallete.secondary;
      }
      else {
        return AppPallete.greyColor;
      }
    }),

    trackOutlineColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppPallete.transparentColor;
      }
      else {
        return AppPallete.darkGrey;
      }
    }),

    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppPallete.softGrey;
      }
      else {
        return AppPallete.darkGrey;
      }
    }),
  );
}

// Track là khung viền của Switch
// Thumb là công tắc đóng mở Switch