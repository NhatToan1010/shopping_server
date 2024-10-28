import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopping_server/data/repositories/user_repository.dart';
import 'package:shopping_server/features/authentication/views/login/login_screen.dart';
import 'package:shopping_server/features/authentication/views/onboarding/onboarding.dart';
import 'package:shopping_server/features/authentication/views/sign_up/verify_email_screen.dart';
import 'package:shopping_server/features/shop/views/navigation_menu.dart';
import 'package:shopping_server/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:shopping_server/utils/exceptions/format_exceptions.dart';
import 'package:shopping_server/utils/exceptions/platform_exceptions.dart';
import 'package:shopping_server/utils/storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // -- Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // -- Get authenticated user data
  User? get authUser => _auth.currentUser;

  // -- Called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // -- Function to show Relevant Screen
  /*
    When the app is opened for the first time,
    deviceStorage will add a 'true' value to the IsFirstTime variable.
    Because at this time, IsFirstTime has a 'null' value.

    Then, when the user goes to the last page of OnBoardingScreen,
    IsFirstTime will be set to 'false' to announce that the next time the user opens the app,
    it will not be the first time the app started anymore.
    Therefore, OnBoardingScreen won't show; instead,
    LoginScreen will be the first screen the user can see.

    If an account has been created also the email has been verified,
    then when the user open app for the next time, they will go straight to HomeScreen.
    Else they will return to Email Verification Screen.
  */
  Future<void> screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        // Initial user specific storage
        await LocalStorage.init(user.uid);

        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: user.email));
      }
    } else {
      // Local Storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      // if IsFirstTime == null => IsFirstTime = true

      // Check if IsFirstTime == false => Goto LogInScreen else Goto OnBoardingScreen
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }

/*-------------------- Email & Password sign-in -------------------- */

  // [Email Authentication] - Sign-In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // [Email Authentication] - Register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) {
    try {
      return _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // [Email Authentication] - Forget Password
  Future<void> sendPasswordReset (String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // [Email Verification] - Send Mail Verification
  Future<void> sendEmailVerificationLink() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // [Email Verification] - Re-authenticate Email and Password
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      // --- Create credential
      final credential = EmailAuthProvider.credential(email: email, password: password);

      // --- Re-authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

/*-------------------- Federated identify & social sign-in -------------------- */

  // [Google Authentication] - Google
  Future<UserCredential> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
      );

      // Once signed in, return user credential
      return await _auth.signInWithCredential(credential);

    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // [Facebook Authentication] - Facebook
  Future<UserCredential> loginWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create credentials from an access token
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return with credentials
      return _auth.signInWithCredential(facebookAuthCredential);

    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

/*-------------------- ./end Federated identify & social sign-in -------------------- */

  // [Logout User] - Valid for any authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // [Delete User] - Remove user Authentication and Firestore Data
  Future<void> deleteAccount() async {
    try {
      // Delete all user data in Database first, then delete user authentication
      await UserRepository.instance.removeUser(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw LocalFirebaseAuthExceptions(e.code).message;
    } on FormatException catch (_) {
      throw const LocalFormatExceptions();
    } on PlatformException catch (e) {
      throw LocalPlatformExceptions(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}
