import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class CustomLoader {
  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        elevation: 0,
        backgroundColor: AppPallete.transparentColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.borderRadiusLarge))
        ),
        content: Container(
          decoration: BoxDecoration(
            color: HelperFunctions.isDarkMode(Get.context!)
                ? AppPallete.lightGrey
                : AppPallete.greyColor,
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.borderRadiusLarge))
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.bodyMedium!.apply(color: AppPallete.textPrimary),
            ),
          ),
        )));
  }

  static announceSnackBar({required title, message = '', duration = 5}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppPallete.whiteColor,
      backgroundColor: AppPallete.info,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon:
          const Icon(Icons.announcement_outlined, color: AppPallete.whiteColor),
    );
  }

  static errorSnackBar({required title, message = '', duration = 10}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      colorText: AppPallete.whiteColor,
      backgroundColor: AppPallete.errorColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon:
          const Icon(Icons.error_outline_rounded, color: AppPallete.whiteColor),
    );
  }

  static successSnackBar({required title, message = '', duration = 5}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      colorText: AppPallete.whiteColor,
      backgroundColor: AppPallete.success,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon:
          const Icon(Icons.done_outline_rounded, color: AppPallete.whiteColor),
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppPallete.whiteColor,
      backgroundColor: AppPallete.warning,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 5),
      margin: const EdgeInsets.all(20),
      icon:
          const Icon(Icons.warning_amber_rounded, color: AppPallete.whiteColor),
    );
  }
}
