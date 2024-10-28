import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/authentication/controllers/signup/signup_controller.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TermsOfServiceWidget extends StatelessWidget {
  const TermsOfServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;

    return Row(
      children: [
        // ----- Checkbox
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value),
          ),
        ),
        const SizedBox(width: AppSize.spaceBtwItems),

        // ----- Terms of Service Text Line
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: '${LocalTexts.iAgree} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: LocalTexts.privacyPolicy,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? AppPallete.secondary : AppPallete.primary),
              ),
              TextSpan(
                  text: ' ${LocalTexts.and} ',
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                text: LocalTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: isDark ? AppPallete.secondary : AppPallete.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
