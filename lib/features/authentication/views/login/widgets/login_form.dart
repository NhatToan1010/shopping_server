import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/authentication/controllers/login/login_controller.dart';
import 'package:shopping_server/features/authentication/views/password_configuration/forget_password.dart';
import 'package:shopping_server/features/authentication/views/sign_up/sign_up_screen.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';
import 'package:shopping_server/utils/validators/validations.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(LoginController());

    return Form(
      key: controller.signInFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSize.spaceBtwSections),
        child: Column(
          children: [
            // ----- Email
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: LocalTexts.email),
            ),
            const SizedBox(height: AppSize.spaceBtwInputField),

            // ----- Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: controller.hidePassword.value
                        ? const Icon(Iconsax.eye_slash)
                        : const Icon(Iconsax.eye),
                  ),
                  labelText: LocalTexts.password,
                ),
              ),
            ),
            const SizedBox(height: AppSize.spaceBtwInputField / 2),

            // Remember me & Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    // ----- Checkbox
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Obx(
                        () => Checkbox(
                          value: controller.isRememberMe.value,
                          onChanged: (value) => controller.isRememberMe.value =
                              !controller.isRememberMe.value,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.spaceBtwItems),
                    // ----- Text
                    Text(LocalTexts.rememberMe, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),

                // ----- Forget Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPasswordScreen()),
                  child: Text(
                    LocalTexts.forgotPassword,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: isDark ? AppPallete.secondary : AppPallete.primary),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSize.spaceBtwSections),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signInWithEmailAndPassword(),
                child: const Text(LocalTexts.login),
              ),
            ),
            const SizedBox(height: AppSize.spaceBtwItems),

            // Create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(LocalTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
