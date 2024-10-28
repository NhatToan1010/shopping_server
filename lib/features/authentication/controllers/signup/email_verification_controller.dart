import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shopping_server/common/widgets/screen_widgets/success_screen.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/constants/texts.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class EmailVerificationController extends GetxController {
  static EmailVerificationController get instance => Get.find();

  // Send email whenever Email Verification Screen appear & Set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    _setTimerForAutoRedirect();
    super.onInit();
  }

  // Send Email verification link
  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerificationLink();
      CustomLoader.announceSnackBar(
          title: 'Email Sent',
          message: 'Please check your email to receive our verification!');
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // Timer to automatically redirect on Email verification
  _setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      await checkEmailVerificationStatus();
    });
  }

  // Manually checked if Email verified
  checkEmailVerificationStatus() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && user.emailVerified) {
      Get.off(() => SuccessScreen(
          title: LocalTexts.emailVerificationSuccessTitle,
          subtitle: LocalTexts.emailVerificationSuccessSubtitle,
          image: LocalImages.emailVerification2,
          onPressed: () => AuthenticationRepository.instance.screenRedirect,
      ));
    }
  }
}
