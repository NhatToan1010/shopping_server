import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/features/personalization/controllers/address_controller.dart';
import 'package:shopping_server/features/personalization/models/address_model.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress(
      {super.key, required this.userAddress, required this.onTap});

  final AddressModel userAddress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    final controller = AddressController.instance;

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final selectedAddress = selectedAddressId == userAddress.id;
      // --- Colors
      final primaryColor = selectedAddress
          ? (isDark ? AppPallete.third : AppPallete.primary)
          : isDark
              ? AppPallete.blackColor
              : AppPallete.lightGrey;
      final primaryText = selectedAddress
          ? (isDark ? AppPallete.textPrimary : AppPallete.textWhite)
          : (isDark ? AppPallete.textWhite : AppPallete.textPrimary);

      return InkWell(
        onTap: onTap,
        child: RoundedContainer(
          // ----- Decorations
          width: double.infinity,
          showBorder: true,
          customColorBorder: selectedAddress,
          backgroundColor: primaryColor,
          borderColor: primaryColor,
          margin: const EdgeInsets.symmetric(vertical: AppSize.extraSmall),

          // ----- Main Content
          child: Padding(
            padding: const EdgeInsets.all(AppSize.defaultSpace),
            child: Stack(
              children: [
                Positioned(
                  right: 8,
                  top: 0,
                  child: Icon(
                    selectedAddress ? Iconsax.tick_circle5 : null,
                    color: isDark ? AppPallete.backgroundDark : AppPallete.backgroundLight,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // --- Receiver Name
                    Text(
                      userAddress.addressName,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: primaryText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSize.spaceBtwItems / 2),

                    // --- Phone No
                    Row(
                      children: [
                        Icon(Iconsax.mobile, color: primaryText, size: 16),
                        const SizedBox(width: AppSize.extraSmall),

                        Text(
                          userAddress.phoneNo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .apply(color: primaryText),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.spaceBtwItems / 2),

                    // --- Delivery Address
                    Row(
                      children: [
                        Icon(Iconsax.location, color: primaryText, size: 16),
                        const SizedBox(width: AppSize.extraSmall),

                        Expanded(
                          child: Text(
                            userAddress.getAddress(),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: primaryText),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
