import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/features/authentication/views/password_configuration/password_reset.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/network/network_manager.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController();
  GlobalKey<FormState> passwordResetFormKey = GlobalKey<FormState>();

  // Send Password Reset Email
  Future<void> sendPasswordResetEmail() async {
    try {
      // Start Loading Screen
      FullScreenLoader.openLoadingDialog(
          'We are processing your request', LocalImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!passwordResetFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Send Password Reset Email
      await AuthenticationRepository.instance
          .sendPasswordReset(email.text.trim());

      // Show Success Loader
      CustomLoader.successSnackBar(
          title: 'Email Sent',
          message: 'We are sending you a password reset link, '
              'Please check your email to create new password');

      // Go to Reset Password Screen
      Get.to(() => PasswordResetScreen(email: email.text.trim()));
    } catch (e) {
      // Stop loading & Show error loader
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message:  e.toString());
    }
  }

  // Resend Password Reset
  resendPasswordResetEmail(String email) async {
    try {
      // Start Loading Screen
      FullScreenLoader.openLoadingDialog(
          'We are processing your request', LocalImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Send Password Reset Email
      await AuthenticationRepository.instance
          .sendPasswordReset(email);

      // Show Success Loader
      CustomLoader.successSnackBar(
          title: 'Email Sent',
          message: 'We are sending you a password reset link, '
              'Please check your email to create new password');
    } catch (e) {
      // Stop loading & Show error loader
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message:  e.toString());
    }
  }
}
