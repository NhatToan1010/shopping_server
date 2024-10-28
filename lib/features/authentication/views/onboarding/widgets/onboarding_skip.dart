import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/device/device_utility.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Positioned(
      top: DeviceUtils.getAppbarHeight(),
      right: AppSize.defaultSpace,
      child: TextButton(
        onPressed: () => controller.lastPage(),
        child: const Text(LocalTexts.skip),
      ),
    );
  }
}