import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/data/repositories/user_repository.dart';
import 'package:shopping_server/features/authentication/models/user_model.dart';
import 'package:shopping_server/features/authentication/views/sign_up/verify_email_screen.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/network/network_manager.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // ----- Variables
  final _auth = AuthenticationRepository.instance;

  final hidePassword = true.obs;
  final privacyPolicy = false.obs;

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // Form key for validation

  // ----- SignUp

  Future<void> signup() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog('We are processing your information...', LocalImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy & Policy Check
      if (!privacyPolicy.value) {
        CustomLoader.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, '
                'you have to check the Terms of Service and Privacy Policy first.');
        return;
      }

      // Call SignUp Method
      _createUserAccount();

      // Move to Verify Email Screen
      FullScreenLoader.stopLoading();

      Get.off(() => VerifyEmailScreen(email: email.text.trim(),));
    } catch (e) {
      // Show generic errors to user
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  _createUserAccount() async {
    // Register user in the Firebase Authentication & Save user date in the Firebase
    final userCredential = await _auth
        .registerWithEmailAndPassword(email.text.trim(), password.text.trim());

    // Save Authentication user data in the Firebase FireStore
    final newUser = UserModel(
      id: userCredential.user!.uid,
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      userName: userName.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      profilePicture: '',
    );

    final userRepository = Get.put(UserRepository());
    await userRepository.saveUserRecord(newUser);
  }
}
