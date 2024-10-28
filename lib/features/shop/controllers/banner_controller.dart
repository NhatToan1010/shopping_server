import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/banner_repository.dart';

import '../../../utils/popups/loader.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  // --- Variables
  final carouselCurrentIndex = 0.obs;
  final _repository = Get.put(BannerRepository());
  RxBool isLoading = false.obs;
  RxList<BannerModel> allBanner = <BannerModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    _fetchAllBanner();
  }

  // --- Update dot indicator
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  // --- Load banner data
  Future<void> _fetchAllBanner() async {
    try {
      // Start loading
      isLoading.value = true;

      // Fetch all banner
      final list = await _repository.getAllBanner();

      // Assign list into allBanner
      allBanner.assignAll(list);

    } catch (e) {
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }
}