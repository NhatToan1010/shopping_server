import 'package:get/get.dart';
import 'package:shopping_server/data/repositories/brand_repository.dart';
import 'package:shopping_server/data/repositories/product_repository.dart';
import 'package:shopping_server/features/shop/models/brand_model.dart';
import 'package:shopping_server/features/shop/models/products/product_model.dart';
import 'package:shopping_server/utils/popups/loader.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // Variables
  RxBool isLoading = false.obs;
  final _repository = Get.put(BrandRepository());
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;

  @override
  void onInit() {
    _fetchData();
    super.onInit();
  }

  // --- Load Brands
  Future<void> _fetchData() async {
    try {
      isLoading.value = true;

      final list = await _repository.getAllItem();

      allBrands.assignAll(list);

      featuredBrands.addAll(allBrands
          .where((item) => item.isFeature ?? false)
          .take(4)
          .toList());
    } catch (e) {
      isLoading.value = false;
      CustomLoader.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // --- Get brands for category

  // --- Get brand specific from data source
  Future<List<ProductModel>> getBrandProducts(String brandId) async {
    final products = ProductRepository.instance.getProductsByBrand(brandId: brandId);

    return products;
  }
}