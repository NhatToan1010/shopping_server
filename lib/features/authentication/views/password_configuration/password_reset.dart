import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopping_server/features/authentication/views/login/login_screen.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Email Verified Image
              Image(
                width: HelperFunctions.screenWidth() * 0.6,
                image: const AssetImage(LocalImages.emailVerification2),
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Headings
              Text(
                LocalTexts.passwordResetTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              // ----- Email
              const SizedBox(height: AppSize.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),

              // ----- Subtitle
              const SizedBox(height: AppSize.spaceBtwItems),
              Text(
                LocalTexts.passwordResetSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Done Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.offAll(() => const LoginScreen()),
                    child: const Text(LocalTexts.done)),
              ),
              const SizedBox(height: AppSize.spaceBtwItems),

              // ----- Resend Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email),
                  child: const Text(LocalTexts.resend),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
