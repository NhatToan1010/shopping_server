import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/personalization/controllers/update_user_detail_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/validators/validations.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateUserDetailController());

    return Scaffold(
      // ----- AppBar
      appBar: const CustomAppbar(title: Text('Change Name'), showBackArrow: true,),

      // ----- Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            // ----- Title
            Text(LocalTexts.changeNameTitle, style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: AppSize.spaceBtwSections),

            // ------ Form Space
            Form(
              key: controller.changeNameFormKey,
              child: Column(
                children: [
                  // ----- First Name
                  TextFormField(
                    controller: controller.firstName,
                    validator: (value) => Validator.validateEmptyText('First Name', value),
                    decoration: const InputDecoration(
                      labelText: LocalTexts.fistName, prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwInputField),

                  // ----- Last Name
                  TextFormField(
                    controller: controller.lastName,
                    validator: (value) => Validator.validateEmptyText('Last Name', value),
                    decoration: const InputDecoration(
                      labelText: LocalTexts.lastName, prefixIcon: Icon(Iconsax.personalcard),
                    ),
                  ),
                  const SizedBox(height: AppSize.spaceBtwSections),

                  // ----- Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.updateNameData(),
                        child: const Text(LocalTexts.save),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
