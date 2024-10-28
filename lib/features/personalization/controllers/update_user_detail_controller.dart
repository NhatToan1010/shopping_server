import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/user_repository.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/features/shop/views/navigation_menu.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/network/network_manager.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class UpdateUserDetailController extends GetxController {
  static UpdateUserDetailController get instance => Get.find();

  // Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  GlobalKey<FormState> changeNameFormKey = GlobalKey<FormState>();
  final userController = UserController.instance;
  final userRepo = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();

    _fetchUserNameDetail();
  }

  void _fetchUserNameDetail() {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  // Update first name and last name to Firestore
  Future<void> updateNameData() async {
    try {
      // Start Loading Screen
      FullScreenLoader.openLoadingDialog('We are processing your request...', LocalImages.loading);

      // Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // From Validation
      if (!changeNameFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Create and Update first name & last name Map value to user data in FireStore
      Map<String, dynamic> name = {
        "FirstName" : firstName.text.trim(),
        "LastName" : lastName.text.trim()
      };
      await userRepo.updateSpecificField(name);

      // Update data for current user
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      // Stop Loading
      FullScreenLoader.stopLoading();

      // Show Success Snack Bar
      CustomLoader.successSnackBar(
          title: 'Success!',
          message: 'Congratulation! Your Name has been updated'
      );

      // Return to Profile Screen
      Get.off(() => const NavigationMenu());
    } catch (e) {
      // Stop Loading & Show Error
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}