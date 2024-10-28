import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/common/widgets/form_widgets/form_title.dart';
import 'package:shopping_server/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/validators/validations.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());

    return Scaffold(
      appBar: const CustomAppbar(
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // Headings
                const FormTitle(
                  title: LocalTexts.forgetPasswordTitle,
                  subtitle: LocalTexts.forgetPasswordSubtitle,
                ),
                const SizedBox(height: AppSize.spaceBtwSections * 2),

                // Email Text Field
                Form(
                  key: controller.passwordResetFormKey,
                  child: TextFormField(
                    controller: controller.email,
                    validator: (value) => Validator.validateEmail(value),
                    decoration: const InputDecoration(
                      labelText: LocalTexts.email,
                      prefixIcon: Icon(Iconsax.direct_right),
                    ),
                  ),
                ),
              ],
            ),

            // Continue Button & Resend Button
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text(LocalTexts.continueText),
                  ),
                ),
                const SizedBox(height: AppSize.spaceBtwItems),
                TextButton(
                  onPressed: () => controller
                      .resendPasswordResetEmail(controller.email.text),
                  child: const Text('Resend'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
