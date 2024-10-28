import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/features/authentication/controllers/signup/email_verification_controller.dart';
import 'package:shopping_server/features/authentication/models/user_model.dart';
import 'package:shopping_server/common/widgets/screen_widgets/success_screen.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email, this.user});

  final String? email;
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());
    final auth = AuthenticationRepository.instance;

    return Scaffold(
      // ----- AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => auth.logout(),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Email Verified Image
              Image(
                width: HelperFunctions.screenWidth() * 0.6,
                image: const AssetImage(LocalImages.emailVerification1),
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Title and Subtitle
              Text(
                LocalTexts.emailVerificationTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceBtwItems),
              Text(
                email ?? '',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceBtwItems),
              Text(
                LocalTexts.emailVerificationSubtitle,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSize.spaceBtwSections),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(
                    () => SuccessScreen(
                      title: LocalTexts.emailVerificationSuccessTitle,
                      subtitle: LocalTexts.emailVerificationSuccessSubtitle,
                      image: LocalImages.emailVerification2,
                      onPressed: () => controller.checkEmailVerificationStatus(),
                    ),
                  ),
                  child: const Text(LocalTexts.continueText),
                ),
              ),
              const SizedBox(height: AppSize.spaceBtwItems),

              // ----- Resend Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => controller.sendEmailVerification(),
                  child: const Text('${LocalTexts.resend} ${LocalTexts.email}'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
