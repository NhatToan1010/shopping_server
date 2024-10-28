import 'package:flutter/material.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class LocalBottomSheetTheme {
  LocalBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = const BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: AppPallete.whiteColor,
    modalBackgroundColor: AppPallete.whiteColor,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusLarge)),
    )
  );

  static BottomSheetThemeData darkBottomSheetTheme = const BottomSheetThemeData(
      showDragHandle: true,
      backgroundColor: AppPallete.blackColor,
      modalBackgroundColor: AppPallete.blackColor,
      constraints: BoxConstraints(minWidth: double.infinity),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusLarge)),
      )
  );
}