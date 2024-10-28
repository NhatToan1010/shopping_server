import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:shopping_server/features/authentication/views/onboarding/widgets/onboarding_button.dart';
import 'package:shopping_server/features/authentication/views/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:shopping_server/features/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:shopping_server/features/authentication/views/onboarding/widgets/onboarding_skip.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/texts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(
                image: LocalImages.onboarding1,
                title: LocalTexts.onboardingTitle1,
                subtitle: LocalTexts.onBoardingSubTitle1,
              ),
              OnboardingPage(
                image: LocalImages.onboarding2,
                title: LocalTexts.onboardingTitle2,
                subtitle: LocalTexts.onBoardingSubTitle2,
              ),
              OnboardingPage(
                image: LocalImages.onboarding3,
                title: LocalTexts.onboardingTitle3,
                subtitle: LocalTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          const OnboardingSkip(),
          const OnboardingDotNavigation(),
          const OnboardingButton()
        ],
      ),
    );
  }
}

