import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/personalization/controllers/address_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/validators/validations.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    // controller.fetchUserInformation();

    return Scaffold(
      // ----- AppBar
      appBar: const CustomAppbar(title: Text('Add New Address'), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                // ----- Name Field
                TextFormField(
                  controller: controller.addressName,
                  validator: (value) => Validator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),

                ),
                const SizedBox(height: AppSize.spaceBtwInputField),

                // ----- Phone No
                TextFormField(
                  controller: controller.phoneNo,
                  validator: (value) => Validator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone No',
                  ),
                ),
                const SizedBox(height: AppSize.spaceBtwInputField),

                // ----- Street & Postal Code
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator: (value) => Validator.validateEmptyText('Street', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building1),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.spaceBtwInputField / 2),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator: (value) => Validator.validateEmptyText('Postal Code', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.spaceBtwInputField),

                // ----- City & State
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator: (value) => Validator.validateEmptyText('City', value),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.spaceBtwInputField / 2),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                          hintText: 'You can skip this field.',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.spaceBtwInputField),

                TextFormField(
                  controller: controller.country,
                  validator: (value) => Validator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(height: AppSize.spaceBtwSections),

                // ----- Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.addNewAddress(),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
