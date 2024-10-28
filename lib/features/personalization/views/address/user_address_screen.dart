import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_server/common/widgets/appbar/custom_appbar.dart';
import 'package:shopping_server/features/personalization/controllers/address_controller.dart';
import 'package:shopping_server/features/personalization/views/address/add_new_address.dart';
import 'package:shopping_server/features/personalization/views/address/widgets/single_address.dart';
import 'package:shopping_server/utils/constants/colors.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      // ----- Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: AppPallete.whiteColor),
      ),

      // ----- AppBar
      appBar: const CustomAppbar(title: Text('Address'), showBackArrow: true),

      // ----- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.defaultSpace),
          child: Obx(
            () => FutureBuilder(
                // Use key to trigger refresh
                key: Key(controller.refreshData.value.toString()),
                future: controller.fetchAllUserAddress(),
                builder: (context, snapshot) {
                  final response =
                      CloudHelperFunctions.checkMultipleStateRecord(
                          snapshot: snapshot);
                  if (response != null) return response;

                  final addresses = snapshot.data!;

                  return ListView.separated(
                    itemCount: addresses.length,
                    shrinkWrap: true,
                    separatorBuilder: (_, index) => const SizedBox(height: AppSize.medium),
                    itemBuilder: (_, index) => SingleAddress(
                      userAddress: addresses[index],
                      onTap: () => controller.changeSelectedAddress(addresses[index]),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
