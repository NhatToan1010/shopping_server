import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/texts/section_heading.dart';
import 'package:shopping_server/data/repositories/address_repository.dart';
import 'package:shopping_server/features/personalization/models/address_model.dart';
import 'package:shopping_server/features/personalization/views/address/add_new_address.dart';
import 'package:shopping_server/features/personalization/views/address/widgets/single_address.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/sizes.dart';
import 'package:shopping_server/utils/helpers/cloud_helper_functions.dart';
import 'package:shopping_server/utils/network/network_manager.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final selectedAddress = AddressModel.empty().obs;
  final refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());

  final addressName = TextEditingController();
  final phoneNo = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  // final userController = Get.put(UserController());

  final GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchAllUserAddress();
  // }

  Future<List<AddressModel>> fetchAllUserAddress() async {
    try {
      final addresses = await addressRepository.getAllUserAddress();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectedAddress,
        orElse: () => AddressModel.empty(),
      );

      if (selectedAddress.value.id.isEmpty) return [];

      return addresses;
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Address Controller Error: ${e.toString()}');
      return [];
    }
  }

  Future changeSelectedAddress(AddressModel newSelectedAddress) async {
    try {
      // Clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedAddress(
            selectedAddress.value.id, false);
      }

      // Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Set the selected variable to true for the newly selected address
      await addressRepository.updateSelectedAddress(
          selectedAddress.value.id, true);
    } catch (e) {
      CustomLoader.errorSnackBar(
          title: 'Address Controller Error: ${e.toString()}');
    }
  }

  Future<void> addNewAddress() async {
    try {
      FullScreenLoader.openLoadingDialog(
          'Storing Address...', LocalImages.loading);

      // --- Check Internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // --- Check Form Validation
      if (!addressFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // --- Add Address to Model
      final address = AddressModel(
        id: '',
        addressName: addressName.text.trim(),
        phoneNo: phoneNo.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        country: country.text.trim(),
        state: state.text.trim(),
        selectedAddress: true,
      );

      // --- Save Address Data
      final addressId = await addressRepository.addNewAddress(address);

      // --- Update Selected Address Status
      address.id = addressId;
      await changeSelectedAddress(address);

      FullScreenLoader.stopLoading();
      CustomLoader.successSnackBar(
        title: 'Congratulation!',
        message: 'Your address has been successfully saved',
      );

      // --- Refresh Data
      refreshData.toggle();

      // --- Clear Text Form Field
      clearField();

      // --- Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(
          title: 'Address Controller Error: ${e.toString()}');
    } finally {
      FullScreenLoader.stopLoading();
    }
  }

  void clearField() {
    addressName.clear();
    phoneNo.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    country.clear();
    state.clear();
    addressFormKey.currentState?.reset();
  }

  // void fetchUserInformation() {
  //   addressName.text = userController.user.value.fullName;
  //   phoneNo.text = userController.user.value.phoneNumber;
  // }

  Future<dynamic> selectAddressOption(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.medium),
        child: Column(
          children: [
            // --- Heading
            const SectionHeading(
              title: 'Select The Address',
              maxLines: 2,
              showActionButton: false,
            ),
            const SizedBox(height: AppSize.spaceBtwSections),

            // --- List Address
            FutureBuilder(
              future: fetchAllUserAddress(),
              builder: (context, snapshot) {
                final response = CloudHelperFunctions.checkMultipleStateRecord(snapshot: snapshot);
                if (response != null) return response;

                final listAddresses = snapshot.data!;

                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: listAddresses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSize.small),
                  itemBuilder: (context, index) => SingleAddress(
                    userAddress: listAddresses[index],
                    onTap: () async {
                      await changeSelectedAddress(listAddresses[index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: AppSize.spaceBtwSections),

            // --- Add New Address Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(const AddNewAddressScreen()),
                child: const Text('Add New Address'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
