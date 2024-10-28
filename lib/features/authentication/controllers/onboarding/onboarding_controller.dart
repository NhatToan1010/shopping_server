import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../views/login/login_screen.dart';


class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  // Attributes
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Update current index & jump to the next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      
      Get.offAll(const LoginScreen());
    } else {
      int nextPage = currentPageIndex.value + 1;
      pageController.jumpToPage(nextPage);
    }
  }

  /*
    When user goes to last page of OnBoardingScreen, IsFirstTime will be set to 'false' value to announce that
    the next time the user opens app will not be the first time the app started anymore.
  */

  // Update current index and jump to the last page
  void lastPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}