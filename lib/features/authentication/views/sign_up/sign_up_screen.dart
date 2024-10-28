import 'package:flutter/material.dart';
import 'package:shopping_server/common/widgets/form_widgets/form_divider.dart';
import 'package:shopping_server/common/widgets/form_widgets/form_title.dart';
import 'package:shopping_server/common/widgets/custom_buttons/social_button.dart';
import 'package:shopping_server/features/authentication/views/sign_up/widgets/sign_up_form.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              FormTitle(title: LocalTexts.signUpTitle, subtitle: LocalTexts.signUpSubtitle),
              SizedBox(height: AppSize.spaceBtwSections * 2),

              // Form
              SignUpForm(),
              SizedBox(height: AppSize.spaceBtwSections),

              // Divider
              FormDivider(method: LocalTexts.signInWith),
              SizedBox(height: AppSize.spaceBtwSections),

              //Social Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(icon: LocalImages.googleIcon),
                  SizedBox(width: AppSize.spaceBtwItems),
                  SocialButton(icon: LocalImages.facebookIcon),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


