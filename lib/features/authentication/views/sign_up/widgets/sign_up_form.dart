import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/authentication/controllers/signup/signup_controller.dart';
import 'package:shopping_server/features/authentication/views/sign_up/widgets/terms_of_service_widget.dart';
import 'package:shopping_server/utils/validators/validations.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // ----- Firstname & Lastname
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ----- Firstname
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => Validator.validateEmptyText('First name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: LocalTexts.fistName,
                      prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(width: AppSize.spaceBtwInputField),

              // ----- Lastname
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      Validator.validateEmptyText('Last name', value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: LocalTexts.lastName,
                      prefixIcon: Icon(Iconsax.personalcard)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.spaceBtwInputField),

          // UserName
          TextFormField(
            controller: controller.userName,
            validator: (value) =>
                Validator.validateEmptyText('User name', value),
            decoration: const InputDecoration(
              labelText: LocalTexts.userName,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: AppSize.spaceBtwInputField),

          // E-Mail
          TextFormField(
            controller: controller.email,
            validator: (value) => Validator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: LocalTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: AppSize.spaceBtwInputField),

          // Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => Validator.validatePhoneNumber(value),
            decoration: const InputDecoration(
              labelText: LocalTexts.phoneNo,
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: AppSize.spaceBtwInputField),

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => Validator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: LocalTexts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  icon: controller.hidePassword.value ? const Icon(Iconsax.eye_slash) : const Icon(Iconsax.eye),
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSize.spaceBtwInputField),

          // Terms of Service checkbox
          const TermsOfServiceWidget(),
          const SizedBox(height: AppSize.spaceBtwSections),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(LocalTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}

