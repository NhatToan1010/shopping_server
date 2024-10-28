import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/features/personalization/controllers/user_controller.dart';
import 'package:shopping_server/utils/network/network_manager.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

import '../../../../utils/constants/image_strings.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  // ----- Variables
  final _localStorage = GetStorage();
  final _auth = AuthenticationRepository.instance;
  final _userController = Get.put(UserController());

  final email = TextEditingController();
  final password = TextEditingController();

  final isRememberMe = false.obs;
  final hidePassword = true.obs;

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  // ---- Fetch data from local storage to text form field
  @override
  void onInit() {
    if (_localStorage.read('REMEMBER_ME_EMAIL') != null && _localStorage.read('REMEMBER_ME_PASSWORD') != null) {
      email.text = _localStorage.read('REMEMBER_ME_EMAIL');
      password.text = _localStorage.read('REMEMBER_ME_PASSWORD');
    }
    super.onInit();
  }

  // ----- Sign-In with email and password
  Future<void> signInWithEmailAndPassword() async {
    try {
      // Start loading screen
      FullScreenLoader.openLoadingDialog('Logging to your account...', LocalImages.loading);

      // Check Internet connectivity
      _internetConnectionCheck();

      // Form validation
      if (!signInFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Call Sign-In Method
      await _signInWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Save data to local storage
      if (isRememberMe.value) {
        _localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        _localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      FullScreenLoader.stopLoading();

      // Redirect
      await _auth.screenRedirect();

    } catch (e) {
      // Show error snack bar
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // ----- Sign-In with Google
  Future<void> signInWithGoogle() async {
    try {
      // Start loading screen
      FullScreenLoader.openLoadingDialog('Logging to your account...', LocalImages.loading);

      // Check Internet connectivity
      _internetConnectionCheck();

      // Google credential
      final userCredential = await _auth.loginWithGoogle();

      // Save user data
      await _userController.saveUserRecord(userCredential);

      // Stop loading
      FullScreenLoader.stopLoading();

      // Redirect
      await _auth.screenRedirect();
    } catch (e) {
      // Show error snack bar
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // ---- Sign-in with Facebook
  Future<void> signInWithFacebook() async {
    try {
      // Start loading screen
      FullScreenLoader.openLoadingDialog('Logging to your account...', LocalImages.loading);

      // Check Internet connectivity
      _internetConnectionCheck();

      // Create Facebook credential
      final userCredential =  await _auth.loginWithFacebook();

      // Save user data
      await _userController.saveUserRecord(userCredential);

      // Stop loading screen
      FullScreenLoader.stopLoading();

      // Redirect Screens
      _auth.screenRedirect();
    } catch (e) {
      // Stop Loading & Show Error
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // ----- Private Methods
  Future<void> _signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _auth.loginWithEmailAndPassword(email, password);
  }

  _internetConnectionCheck() async {
    final isInternetConnected = await NetworkManager.instance.isConnected();
    if (!isInternetConnected) {
      FullScreenLoader.stopLoading();
      return;
    }
  }
}