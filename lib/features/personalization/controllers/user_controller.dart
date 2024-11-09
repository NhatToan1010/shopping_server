import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_server/data/repositories/authentication_repository.dart';
import 'package:shopping_server/data/repositories/user_repository.dart';
import 'package:shopping_server/features/authentication/models/user_model.dart';
import 'package:shopping_server/features/authentication/views/login/login_screen.dart';
import 'package:shopping_server/features/personalization/views/profile/widgets/re_authenticate_screen.dart';
import 'package:shopping_server/utils/constants/image_strings.dart';
import 'package:shopping_server/utils/network/network_manager.dart';
import 'package:shopping_server/utils/popups/full_screen_loader.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  // --- Variables
  final _userRepo = Get.put(UserRepository());

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final hidePassword = false.obs;

  Rx<UserModel> user = UserModel.empty().obs;
  RxBool isProfileLoading = true.obs;
  RxBool isImageLoading = false.obs;
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  // ----- On Init State
  @override
  void onInit() {
    super.onInit();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      isProfileLoading.value = true;
      final userDetails = await _userRepo.fetchUserDetail();
      user(userDetails);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isProfileLoading.value = false;
    }
  }

  // ----- Save Userdata to Firestore
  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      // First, fetch user data to local device if they have already signed up
      await _fetchUserDetails();

      // Second, check if the user UID is null then create a new document in Database
      if (user.value.id.isEmpty) {
        if (userCredential != null) {
          final nameParts =
              UserModel.nameParts(userCredential.user!.displayName ?? '');
          final userName = UserModel.generateUserNameFormFullName(
              userCredential.user!.displayName ?? '');

          // Map data
          final user = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            userName: userName,
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '',
          );

          // Save user data
          await UserRepository.instance.saveUserRecord(user);
        }
      }
    } catch (e) {
      CustomLoader.warningSnackBar(
          title: 'Data not be saved',
          message:
              'Something went wrong while saving your information, please check again!');
    }
  }

  // ----- Remove User Account from Firestore
  Future<void> deleteUserAccount() async {
    try {
      // Start Loading Screen
      FullScreenLoader.openLoadingDialog(
          'We are processing your request...', LocalImages.loading);

      // Re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;

      if (provider.isNotEmpty) {
        // Re verify auth email
        if (provider == 'google.com') {
          await auth.loginWithGoogle();
          await auth.deleteAccount();
          FullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          // Move to Re-authenticate Screen
          FullScreenLoader.stopLoading();
          Get.to(() => const ReAuthenticateScreen());
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // ----- Re-authenticate User
  Future<void> reAuthenticateWithEmailAndPassword() async {
    try {
      // Start Loading Screen
      FullScreenLoader.openLoadingDialog('We are processing your request...', LocalImages.loading);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Re-authenticate & Delete Account
      AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(
          verifyEmail.text.trim(), verifyPassword.text.trim());
      AuthenticationRepository.instance.deleteAccount();

      FullScreenLoader.stopLoading();

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  // ----- Upload user's profile picture
  Future<void> uploadUserImage() async {
    try {
      // Open local device gallery to choose an image
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (image != null) {
        isProfileLoading.value = true;
        // Upload image into Firebase Storage
        final imageUrl = await _userRepo.uploadImage('Users/Images/Profile', image);

        // Upload image to Database
        Map<String, dynamic> profilePicture = {"ProfilePicture" : imageUrl};
        await _userRepo.updateSpecificField(profilePicture);

        // Set updated image to UI of local device
        user.value.profilePicture = imageUrl;
        user.refresh();

        // Show snack bar
        CustomLoader.successSnackBar(
            title: 'Congratulation!',
            message: 'Your avatar is successfully updated!'
        );
      } else {
      }
    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isImageLoading.value = false;
    }
  }
}
