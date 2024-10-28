import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(OnboardingController());

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      left: (DeviceUtils.getScreenWidth() * 0.5) - 30,
      child: ElevatedButton(
        onPressed: () => controller.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: isDark ? AppPallete.whiteColor :  AppPallete.blackColor
        ),
        child: Icon(
          Icons.navigate_next_rounded,
          color: isDark ? AppPallete.blackColor : AppPallete.whiteColor,
        ),
      ),
    );
  }
}
