import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/validators/validations.dart';

class ReAuthenticateScreen extends StatelessWidget {
  const ReAuthenticateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;

    return Scaffold(
      // ----- App Bar
      appBar: const CustomAppbar(
          title: Text('Re Authentication'), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            // ----- Title
            Text(
              LocalTexts.reAuthScreenTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSize.spaceBtwSections),

            // ----- Form Space
            Form(
              key: controller.reAuthFormKey,
              child: Column(
                children: [
                  // ----- Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: (value) => Validator.validateEmail(value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: LocalTexts.email),
                  ),
                  const SizedBox(height: AppSize.spaceBtwInputField),

                  // ----- Password
                  Obx(
                    () => TextFormField(
                      controller: controller.verifyPassword,
                      validator: (value) => Validator.validateEmptyText('Password', value),
                      decoration: InputDecoration(
                        labelText: LocalTexts.password,
                        prefixIcon: const Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: controller.hidePassword.value
                              ? const Icon(Iconsax.eye_slash)
                              : const Icon(Iconsax.eye),
                        ),
                      ),
                      obscureText: controller.hidePassword.value,
                    ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),

                  // ----- Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.reAuthenticateWithEmailAndPassword(),
                      child: const Text('Proceed'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
