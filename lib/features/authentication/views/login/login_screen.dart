
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/styles/spacing_styles.dart';
import 'package:shopping_server/features/authentication/controllers/login/login_controller.dart';
import 'package:shopping_server/features/authentication/views/login/widgets/login_form.dart';
import 'package:shopping_server/common/widgets/form_widgets/form_divider.dart';
import 'package:shopping_server/common/widgets/form_widgets/form_title.dart';
import 'package:shopping_server/common/widgets/custom_buttons/social_button.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';

import '../../../../utils/constants/image_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyles.paddingWithAppbarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Subtitle
              const FormTitle(
                title: LocalTexts.loginTitle,
                subtitle: LocalTexts.loginSubtitle,
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Form
              const LoginForm(),

              // Divider
              const FormDivider(method: LocalTexts.signInWith),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ----- Google Sign-In
                  SocialButton(
                    icon: LocalImages.googleIcon,
                    onTap: () => controller.signInWithGoogle(),
                  ),
                  const SizedBox(width: AppSize.spaceBtwItems),

                  // ----- Facebook Sign-In
                  SocialButton(
                    icon: LocalImages.facebookIcon,
                    onTap: () => controller.signInWithFacebook(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
