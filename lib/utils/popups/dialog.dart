import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class CustomDialog {
  static alertDialog({required title, message, required onPressed}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
      ),
      confirm: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppPallete.primary),
        child: const Text('Continue'),
      ),
    );
  }

  static deleteAccountWarningDialog({required onConfirmPressed}) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(AppSize.medium),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete this account from our app?',
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel'),
      ),
      confirm: ElevatedButton(
        onPressed: onConfirmPressed,
        style: ElevatedButton.styleFrom(backgroundColor: AppPallete.errorColor),
        child: const Text('Continue'),
      ),
    );
  }
}
