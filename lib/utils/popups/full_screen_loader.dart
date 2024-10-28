import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/loaders/animation_loader.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class FullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      builder: (_) => PopScope(
        child: Container(
          color: HelperFunctions.isDarkMode(Get.context!) ? AppPallete.backgroundDark : AppPallete.backgroundLight,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              CustomAnimationLoader(text: text, animation: animation)
            ],
          ),
        ),
      ),
    );
  }

  // Stop currently animation
  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
