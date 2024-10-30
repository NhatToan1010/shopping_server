import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/features/personalization/controllers/address_controller.dart';
import 'package:shopping_server/utils/constants/sizes.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () => addressController.selectAddressOption(context),
        ),
        const SizedBox(height: AppSize.small),

        // --- Name, Phone No, & Shipping Location
        Obx(
          () {
            if (addressController.selectedAddress.value.id.isEmpty) {
              return Text(
                'Select address for deliver.',
                style: Theme.of(context).textTheme.labelMedium,
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ----- Name Shipping User
                Text(
                  addressController.selectedAddress.value.addressName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSize.small),

                // ----- Phone Number
                Wrap(
                  spacing: AppSize.small,
                  children: [
                    const Icon(
                      Icons.phone,
                      size: 16,
                      color: Colors.grey,
                    ),
                    Text(
                      addressController.selectedAddress.value.phoneNo,
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
                const SizedBox(height: AppSize.small),

                // ----- Shipping Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: AppSize.small),

                    Expanded(
                      child: Text(
                        addressController.selectedAddress.value.getAddress(),
                        style: Theme.of(context).textTheme.labelLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppSize.small),
              ],
            );
          },
        ),
      ],
    );
  }
}
