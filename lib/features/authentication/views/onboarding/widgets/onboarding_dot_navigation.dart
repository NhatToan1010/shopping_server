import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(OnboardingController());

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight() + 150,
      left: (DeviceUtils.getScreenWidth() * 0.5) - 50,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
          activeDotColor: isDark ? AppPallete.lightGrey : AppPallete.darkerGrey,
          dotHeight: 6,
          dotColor: AppPallete.darkGrey,
        ),
      ),
    );
  }
}
